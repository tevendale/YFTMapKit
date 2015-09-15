//
//  MKGeocoder.m
//  MapKit
//
//  Created by Rick Fillion on 11-01-02.
//  Copyright 2011 Centrix.ca. All rights reserved.
//

/*
 Note:  Read comments at the top of MKReverseGeocoder, as they apply here too.
 */

#import "YFTMKGeocoder.h"
#import "JSON.h"
#import "YFTMKPlacemark+Private.h"

@interface YFTMKGeocoder (WebViewIntegration)

- (void)didSucceedWithResult:(NSString *)jsonEncodedGeocoderResult;
- (void)didFailWithError:(NSString *)status;
- (void)didReachQueryLimit;

@end


@interface YFTMKGeocoder (Private)

- (void)createWebView;
- (void)destroyWebView;
- (void)_start;

@end


@implementation YFTMKGeocoder

@synthesize delegate;
@synthesize address;
@synthesize coordinate;
@synthesize querying;

+ (NSString *) webScriptNameForSelector:(SEL)sel
{
    NSString *name = nil;
    
    if (sel == @selector(didSucceedWithResult:))
    {
        name = @"didSucceedWithResult";
    }
    
    if (sel == @selector(didFailWithError:))
    {
        name = @"didFailWithError";
    }
    
    if (sel == @selector(didReachQueryLimit))
    {
	name = @"didReachQueryLimit";
    }
    
    
    return name;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector
{
    if (aSelector == @selector(didSucceedWithResult:))
    {
        return NO;
    }
    
    if (aSelector == @selector(didFailWithError:))
    {
        return NO;
    }
    
    if (aSelector == @selector(didReachQueryLimit))
    {
	return NO;
    }
    
    return YES;
}


- (id)initWithAddress:(NSString *)anAddress
{
    if (self = [super init])
    {
        [self createWebView];
        address = anAddress;
        hasOriginatingCoordinate = NO;
    }
    return self;
}

- (id)initWithAddress:(NSString *)anAddress nearCoordinate:(CLLocationCoordinate2D)aCoordinate
{
    if (self = [super init])
    {
        [self createWebView];
        address = anAddress;
        hasOriginatingCoordinate = YES;
        originatingCoordinate = aCoordinate;
    }
    return self;
}


- (void)dealloc
{
    [self destroyWebView];
}


- (void)start
{
    if (querying)
        return;
    querying = YES;
    if (webViewLoaded)
        [self _start];
}

- (void)cancel
{
    if (!querying)
        return;
    querying = NO;
}

#pragma mark WebViewIntegration

- (void)didSucceedWithResult:(NSString *)jsonEncodedGeocoderResult;
{
    //NSLog(@"didSucceedWithResult: %@", jsonEncodedGeocoderResult);
    if (!querying)
        return;
    
    id result = [jsonEncodedGeocoderResult JSONValue];
    YFTMKPlacemark *aPlacemark = [[YFTMKPlacemark alloc] initWithGoogleGeocoderResult: result];
    coordinate = aPlacemark.coordinate;
    
    if (delegate && [delegate respondsToSelector:@selector(geocoder:didFindCoordinate:)])
    {
        [delegate geocoder:self didFindCoordinate:self.coordinate];
    }

    querying = NO;
}



- (void)didFailWithError:(NSString *)domain
{
    //NSLog(@"didFailWithErorr: %@", domain);
    if (!querying)
        return;
    
    NSError *error = [NSError errorWithDomain:domain code:0 userInfo:nil];
    // TODO create error
    
    if (delegate && [delegate respondsToSelector:@selector(geocoder:didFailWithError:)])
    {
        [delegate geocoder:self didFailWithError:error];
    }
    querying = NO;
}

- (void)didReachQueryLimit
{
    // Retry again in half a second
    if (self.querying)
    {
	[self performSelector:@selector(_start) withObject:nil afterDelay:0.5];
    }
}

#pragma mark WebFrameLoadDelegate

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowScriptObject forFrame:(WebFrame *)frame
{
    //NSLog(@"didClearWindowObjet");
    [windowScriptObject setValue:self forKey:@"YFTMKGeocoder"];
}


- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    //NSLog(@"didFinishLoad:");
    [[webView windowScriptObject] setValue:self forKey:@"YFTMKGeocoder"];
    webViewLoaded = YES;
    if (self.querying && [sender mainFrame] == frame)
    {
        [self _start];
    }
}

#pragma mark Private

- (void)createWebView
{
    // TODO : make this suck less.
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[YFTMKGeocoder class]];
    NSString *indexPath = [frameworkBundle pathForResource:@"MapKit" ofType:@"html"];
    webView = [[WebView alloc] initWithFrame:NSZeroRect frameName:nil groupName:nil];
    [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]]; 
    [[webView windowScriptObject] setValue:self forKey:@"YFTMKGeocoder"];
    [webView setFrameLoadDelegate:self];
}

- (void)destroyWebView
{
    [webView close];
}

- (void)_start
{
    //NSLog(@"start");
    NSArray *args = nil;
    if (hasOriginatingCoordinate)
        args = [NSArray arrayWithObjects:
                     self.address,
                     [NSNumber numberWithDouble:originatingCoordinate.latitude],
                     [NSNumber numberWithDouble:originatingCoordinate.longitude],
                     nil];
    else {
        args = [NSArray arrayWithObject: self.address];
    }


    WebScriptObject *webScriptObject = [webView windowScriptObject];
    //NSLog(@"got webscriptobject");
    id val = [webScriptObject callWebScriptMethod:@"geocode" withArguments:args];
    //NSLog(@"val = %@", val);
    if (!val)
    {
        // something went wrong, call the failure delegate
        //NSLog(@"MKReverseGeocoder tried to start but the script wasn't ready, rescheduling");
        [self performSelector:@selector(_start) withObject:nil afterDelay:0.1];
    }
}


@end
