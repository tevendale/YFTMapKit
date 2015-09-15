//
//  DemoAppApplicationDelegate.m
//  MapKit
//
//  Created by Rick Fillion on 7/16/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "DemoAppApplicationDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <YFTMapKit/YFTMapKit.h>

@implementation DemoAppApplicationDelegate

@synthesize window;
@synthesize pinTitle;

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    //NSLog(@"applicationDidFinishLaunching:");    
    [mapView setShowsUserLocation: YES];
    [mapView setDelegate: self];
    
//    pinNames = [[NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", @"Eleven", @"Twelve", nil] retain];
//
//    
//    CLLocationCoordinate2D coordinate;
//    coordinate.latitude = 49.8578255;
//    coordinate.longitude = -97.16531639999999;
//    MKReverseGeocoder *reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate: coordinate];
//    reverseGeocoder.delegate = self;
//    [reverseGeocoder start];
//    
//    coreLocationPins = [[NSMutableArray array] retain];
//    
//    MKGeocoder *geocoderNoCoord = [[MKGeocoder alloc] initWithAddress:@"777 Corydon Ave, Winnipeg MB"];
//    geocoderNoCoord.delegate = self;
//    [geocoderNoCoord start];
//    
//    MKGeocoder *geocoderCoord = [[MKGeocoder alloc] initWithAddress:@"1250 St. James St" nearCoordinate:coordinate];
//    geocoderCoord.delegate = self;
//    [geocoderCoord start];
    
}

- (IBAction)setMapType:(id)sender
{
    NSSegmentedControl *segmentedControl = (NSSegmentedControl *)sender;
    [mapView setMapType:[segmentedControl selectedSegment]];
}

- (IBAction)addCircle:(id)sender
{
    YFTMKCircle *circle = [YFTMKCircle circleWithCenterCoordinate:[mapView centerCoordinate] radius:[circleRadius intValue]];
    [mapView addOverlay:circle];
}

- (IBAction)addPin:(id)sender
{
    YFTMKPointAnnotation *pin = [[YFTMKPointAnnotation alloc] init];
    pin.coordinate = [mapView centerCoordinate];
    pin.title = self.pinTitle;
    
    YFTMKCircle *circle = [YFTMKCircle circleWithCenterCoordinate:[mapView centerCoordinate] radius:300];
    
    NSMutableDictionary *coreLocationPin = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            pin, @"pin",
                                            circle, @"circle",
                                            nil];
    
    [coreLocationPins addObject:coreLocationPin];
    
    [mapView addAnnotation:pin];
    [mapView addOverlay:circle];
}

- (IBAction)searchAddress:(id)sender
{
    [mapView showAddress:[addressTextField stringValue]];
}

- (IBAction)demo:(id)sender
{
    for (int i = 0; i<[pinNames count]; i++)
    {
        [self performSelector:@selector(addPinForIndex:) withObject:[NSNumber numberWithInt:i] afterDelay: i * 0.25];
    }
}

- (void)addPinForIndex:(NSNumber *)indexNumber
{
    CLLocationCoordinate2D centerCoordinate = [mapView centerCoordinate];
    NSUInteger total = [pinNames count];
    NSUInteger index = [indexNumber intValue];
    double maxLatOffset = 0.01;
    double maxLngOffset = 0.02;
    NSString *name = [pinNames objectAtIndex:[indexNumber intValue]];

    YFTMKPointAnnotation *pin = [[YFTMKPointAnnotation alloc] init];
    CLLocationCoordinate2D pinCoord = centerCoordinate;
    double latOffset = maxLatOffset * cosf(2*M_PI * ((double)index/(double)total));
    double lngOffset = maxLngOffset * sinf(2*M_PI * ((double)index/(double)total));
    pinCoord.latitude += latOffset;
    pinCoord.longitude += lngOffset;
    pin.coordinate = pinCoord;
    pin.title = name;
    [mapView addAnnotation:pin];

}

- (IBAction)addAdditionalCSS:(id)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MapViewAdditions" ofType:@"css"];
    [mapView performSelector:@selector(addStylesheetTag:) withObject:path afterDelay:1.0];
}

#pragma mark MKReverseGeocoderDelegate

- (void)reverseGeocoder:(YFTMKReverseGeocoder *)geocoder didFindPlacemark:(YFTMKPlacemark *)placemark
{
    //NSLog(@"found placemark: %@", placemark);
}

- (void)reverseGeocoder:(YFTMKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    //NSLog(@"MKReverseGeocoder didFailWithError: %@", error);
}

#pragma mark MKGeocoderDelegate

- (void)geocoder:(YFTMKGeocoder *)geocoder didFindCoordinate:(CLLocationCoordinate2D)coordinate
{
    //NSLog(@"MKGeocoder found (%f, %f) for %@", coordinate.latitude, coordinate.longitude, geocoder.address);
}

- (void)geocoder:(YFTMKGeocoder *)geocoder didFailWithError:(NSError *)error
{
    //NSLog(@"MKGeocoder didFailWithError: %@", error);
}

#pragma mark MapView Delegate

// Responding to Map Position Changes

- (void)mapView:(YFTMKMapView *)aMapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"mapView: %@ regionWillChangeAnimated: %d", aMapView, animated);
}

- (void)mapView:(YFTMKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"mapView: %@ regionDidChangeAnimated: %d", aMapView, animated);
}

//Loading the Map Data
- (void)mapViewWillStartLoadingMap:(YFTMKMapView *)aMapView
{
    NSLog(@"mapViewWillStartLoadingMap: %@", aMapView);
}

- (void)mapViewDidFinishLoadingMap:(YFTMKMapView *)aMapView
{
    NSLog(@"mapViewDidFinishLoadingMap: %@", aMapView);
}

- (void)mapViewDidFailLoadingMap:(YFTMKMapView *)aMapView withError:(NSError *)error
{
    NSLog(@"mapViewDidFailLoadingMap: %@ withError: %@", aMapView, error);
}

// Tracking the User Location
- (void)mapViewWillStartLocatingUser:(YFTMKMapView *)aMapView
{
    NSLog(@"mapViewWillStartLocatingUser: %@", aMapView);
}

- (void)mapViewDidStopLocatingUser:(YFTMKMapView *)aMapView
{
    NSLog(@"mapViewDidStopLocatingUser: %@", aMapView);
}

- (void)mapView:(YFTMKMapView *)aMapView didUpdateUserLocation:(YFTMKUserLocation *)userLocation
{
    NSLog(@"mapView: %@ didUpdateUserLocation: %@", aMapView, userLocation);
}

- (void)mapView:(YFTMKMapView *)aMapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"mapView: %@ didFailToLocateUserWithError: %@", aMapView, error);
}

// Managing Annotation Views


- (YFTMKAnnotationView *)mapView:(YFTMKMapView *)aMapView viewForAnnotation:(id <YFTMKAnnotation>)annotation
{
    //NSLog(@"mapView: %@ viewForAnnotation: %@", aMapView, annotation);
    //MKAnnotationView *view = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"blah"] autorelease];
    YFTMKPinAnnotationView *view = [[YFTMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"blah"];
    view.draggable = YES;
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"MarkerTest" ofType:@"png"];
    //NSURL *url = [NSURL fileURLWithPath:path];
    //view.imageUrl = [url absoluteString];
    return view;
}
 
- (void)mapView:(YFTMKMapView *)aMapView didAddAnnotationViews:(NSArray *)views
{
    //NSLog(@"mapView: %@ didAddAnnotationViews: %@", aMapView, views);
}
 /*
 - (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
 {
 NSLog(@"mapView: %@ annotationView: %@ calloutAccessoryControlTapped: %@", aMapView, view, control);
 }
 */

// Dragging an Annotation View
/*
 - (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)annotationView 
 didChangeDragState:(MKAnnotationViewDragState)newState 
 fromOldState:(MKAnnotationViewDragState)oldState
 {
 NSLog(@"mapView: %@ annotationView: %@ didChangeDragState: %d fromOldState: %d", aMapView, annotationView, newState, oldState);
 }
 */


// Selecting Annotation Views

- (void)mapView:(YFTMKMapView *)aMapView didSelectAnnotationView:(YFTMKAnnotationView *)view
{
    //NSLog(@"mapView: %@ didSelectAnnotationView: %@", aMapView, view);
}

- (void)mapView:(YFTMKMapView *)aMapView didDeselectAnnotationView:(YFTMKAnnotationView *)view
{
    //NSLog(@"mapView: %@ didDeselectAnnotationView: %@", aMapView, view);
}


// Managing Overlay Views

- (YFTMKOverlayView *)mapView:(YFTMKMapView *)aMapView viewForOverlay:(id <YFTMKOverlay>)overlay
{
    //NSLog(@"mapView: %@ viewForOverlay: %@", aMapView, overlay);
    YFTMKCircleView *circleView = [[YFTMKCircleView alloc] initWithCircle:overlay];
    return circleView;
    //    MKPolylineView *polylineView = [[[MKPolylineView alloc] initWithPolyline:overlay] autorelease];
    //    return polylineView;
    YFTMKPolygonView *polygonView = [[YFTMKPolygonView alloc] initWithPolygon:overlay];
    return polygonView;
}

- (void)mapView:(YFTMKMapView *)aMapView didAddOverlayViews:(NSArray *)overlayViews
{
    //NSLog(@"mapView: %@ didAddOverlayViews: %@", aMapView, overlayViews);
}

- (void)mapView:(YFTMKMapView *)aMapView annotationView:(YFTMKAnnotationView *)annotationView didChangeDragState:(YFTMKAnnotationViewDragState)newState fromOldState:(YFTMKAnnotationViewDragState)oldState
{
    //NSLog(@"mapView: %@ annotationView: %@ didChangeDragState:%d fromOldState:%d", aMapView, annotationView, newState, oldState);
    
    if (newState ==  MKAnnotationViewDragStateEnding || newState == MKAnnotationViewDragStateNone)
    {
        // create a new circle view
        YFTMKPointAnnotation *pinAnnotation = annotationView.annotation;
        for (NSMutableDictionary *pin in coreLocationPins)
        {
            if ([[pin objectForKey:@"pin"] isEqual: pinAnnotation])
            {
                // found the pin.
                YFTMKCircle *circle = [pin objectForKey:@"circle"];
                CLLocationDistance pinCircleRadius = circle.radius;
                [aMapView removeOverlay:circle];
                
                circle = [YFTMKCircle circleWithCenterCoordinate:pinAnnotation.coordinate radius:pinCircleRadius];
                [pin setObject:circle forKey:@"circle"];
                [aMapView addOverlay:circle];
            }
        }
    }
    else {
        // find old circle view and remove it
        YFTMKPointAnnotation *pinAnnotation = annotationView.annotation;
        for (NSMutableDictionary *pin in coreLocationPins)
        {
            if ([[pin objectForKey:@"pin"] isEqual: pinAnnotation])
            {
                // found the pin.
                YFTMKCircle *circle = [pin objectForKey:@"circle"];
                [aMapView removeOverlay:circle];
            }
        }
    }

    
    //MKPointAnnotation *annotation = annotationView.annotation;
    //NSLog(@"annotation = %@", annotation);
    
}

// MacMapKit additions
- (void)mapView:(YFTMKMapView *)aMapView userDidClickAndHoldAtCoordinate:(CLLocationCoordinate2D)coordinate;
{
    //NSLog(@"mapView: %@ userDidClickAndHoldAtCoordinate: (%f, %f)", aMapView, coordinate.latitude, coordinate.longitude);
    YFTMKPointAnnotation *pin = [[YFTMKPointAnnotation alloc] init];
    pin.coordinate = coordinate;
    pin.title = @"Hi.";
    [mapView addAnnotation:pin];
}

- (NSArray *)mapView:(YFTMKMapView *)mapView contextMenuItemsForAnnotationView:(YFTMKAnnotationView *)view
{
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"Delete It" action:@selector(delete:) keyEquivalent:@""];
    return [NSArray arrayWithObject:item];
}


@end
