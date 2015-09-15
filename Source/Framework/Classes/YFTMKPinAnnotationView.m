//
//  MKPinAnnotationView.m
//  MapKit
//
//  Created by Rick Fillion on 7/18/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "YFTMKPinAnnotationView.h"


@implementation YFTMKPinAnnotationView

@synthesize pinColor;
@synthesize animatesDrop;

- (id)initWithAnnotation:(id <YFTMKAnnotation>)anAnnotation reuseIdentifier:(NSString *)aReuseIdentifier
{
    if (self = [super initWithAnnotation:anAnnotation reuseIdentifier:aReuseIdentifier])
    {
        self.canShowCallout = YES;
    }
    return self;
}

- (NSString *)imageUrl
{
    NSBundle *bundle = [NSBundle bundleForClass:[YFTMKPinAnnotationView class]];
    NSString *filename = nil;
    switch (pinColor) {
        case YFTMKPinAnnotationColorRed:
            filename = @"MKPinAnnotationColorRed";
            break;
        case YFTMKPinAnnotationColorGreen:
            filename = @"MKPinAnnotationColorGreen";
            break;
        case YFTMKPinAnnotationColorPurple:
            filename = @"MKPinAnnotationColorPurple";
            break;
        default:
            filename = @"MKPinAnnotationColorRed";
            break;
    }
    NSString *path = [bundle pathForResource:filename ofType:@"png"];
    NSURL *url = [NSURL fileURLWithPath:path];
    return [url absoluteString];
}

@end
