//
//  DemoAppApplicationDelegate.h
//  MapKit
//
//  Created by Rick Fillion on 7/16/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMapKit.h>

@class YFTMKMapView;

@interface DemoAppApplicationDelegate : NSObject <NSApplicationDelegate, MKMapViewDelegate, YFTMKReverseGeocoderDelegate, YFTMKGeocoderDelegate> {
    NSWindow *__strong window;
    IBOutlet YFTMKMapView *mapView;
    IBOutlet NSTextField *addressTextField;
    NSNumber *circleRadius;
    NSString *pinTitle;
    NSArray *pinNames;
    
    NSMutableArray *coreLocationPins;
}

@property (strong) IBOutlet NSWindow *window;
@property (strong) NSString *pinTitle;

- (IBAction)setMapType:(id)sender;
- (IBAction)addCircle:(id)sender;
- (IBAction)addPin:(id)sender;
- (IBAction)searchAddress:(id)sender;
- (IBAction)demo:(id)sender;
- (IBAction)addAdditionalCSS:(id)sender;

@end
