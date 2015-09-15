//
//  MKMapView.h
//  MapKit
//
//  Created by Rick Fillion on 7/11/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <CoreLocation/CoreLocation.h>
#import <YFTMapKit/YFTMKTypes.h>
#import <YFTMapKit/YFTMKGeometry.h>
#import <YFTMapKit/YFTMKOverlay.h>
#import <YFTMapKit/YFTMKAnnotationView.h>

@protocol MKMapViewDelegate;
@class YFTMKUserLocation;
@class YFTMKOverlayView;
@class YFTMKWebView;

@interface YFTMKMapView : NSView <CLLocationManagerDelegate, NSCoding> {    
    id <MKMapViewDelegate> __strong delegate;
    YFTMKMapType mapType;
    YFTMKUserLocation *userLocation;
    BOOL showsUserLocation;
    NSMutableArray *overlays;
    NSMutableArray *annotations;
    NSMutableArray *selectedAnnotations;
    
@private
    YFTMKWebView *webView;
    CLLocationManager *locationManager;
    BOOL hasSetCenterCoordinate;
    // Overlays
    NSMapTable *overlayViews;
    NSMapTable *overlayScriptObjects;
    // Annotations
    NSMapTable *annotationViews;
    NSMapTable *annotationScriptObjects;

    
}
@property (nonatomic, strong) id <MKMapViewDelegate> delegate;

@property(nonatomic) YFTMKMapType mapType;
@property(nonatomic, readonly) YFTMKUserLocation *userLocation;
@property(nonatomic) YFTMKCoordinateRegion region;
@property(nonatomic) CLLocationCoordinate2D centerCoordinate;
@property(nonatomic) BOOL showsUserLocation;
@property(nonatomic, getter=isScrollEnabled) BOOL scrollEnabled;
@property(nonatomic, getter=isZoomEnabled) BOOL zoomEnabled;
@property(nonatomic, readonly, getter=isUserLocationVisible) BOOL userLocationVisible;
@property(nonatomic, readonly) NSArray *overlays;
@property(nonatomic, readonly) NSArray *annotations;
@property(nonatomic, copy) NSArray *selectedAnnotations;


- (void)setCenterCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;
- (void)setRegion:(YFTMKCoordinateRegion)region animated:(BOOL)animated;

// Overlays
- (void)addOverlay:(id < YFTMKOverlay >)overlay;
- (void)addOverlays:(NSArray *)overlays;
- (void)exchangeOverlayAtIndex:(NSUInteger)index1 withOverlayAtIndex:(NSUInteger)index2;
- (void)insertOverlay:(id < YFTMKOverlay >)overlay aboveOverlay:(id < YFTMKOverlay >)sibling;
- (void)insertOverlay:(id < YFTMKOverlay >)overlay atIndex:(NSUInteger)index;
- (void)insertOverlay:(id < YFTMKOverlay >)overlay belowOverlay:(id < YFTMKOverlay >)sibling;
- (void)removeOverlay:(id < YFTMKOverlay >)overlay;
- (void)removeOverlays:(NSArray *)overlays;
- (YFTMKOverlayView *)viewForOverlay:(id < YFTMKOverlay >)overlay;

// Annotations
- (void)addAnnotation:(id < YFTMKAnnotation >)annotation;
- (void)addAnnotations:(NSArray *)annotations;
- (void)removeAnnotation:(id < YFTMKAnnotation >)annotation;
- (void)removeAnnotations:(NSArray *)annotations;
- (YFTMKAnnotationView *)viewForAnnotation:(id < YFTMKAnnotation >)annotation;
- (YFTMKAnnotationView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier;
- (void)selectAnnotation:(id < YFTMKAnnotation >)annotation animated:(BOOL)animated;
- (void)deselectAnnotation:(id < YFTMKAnnotation >)annotation animated:(BOOL)animated;

// Converting Map Coordinates
- (NSPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(NSView *)view;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(NSView *)view;
- (YFTMKCoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(NSView *)view;
- (NSRect)convertRegion:(YFTMKCoordinateRegion)region toRectToView:(NSView *)view;

@end


@protocol MKMapViewDelegate <NSObject>
@optional

- (void)mapView:(YFTMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
- (void)mapView:(YFTMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;

- (void)mapViewWillStartLoadingMap:(YFTMKMapView *)mapView;
- (void)mapViewDidFinishLoadingMap:(YFTMKMapView *)mapView;
- (void)mapViewDidFailLoadingMap:(YFTMKMapView *)mapView withError:(NSError *)error;

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (YFTMKAnnotationView *)mapView:(YFTMKMapView *)mapView viewForAnnotation:(id <YFTMKAnnotation>)annotation;

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(YFTMKMapView *)mapView didAddAnnotationViews:(NSArray *)views;

// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;

// Overlays
- (YFTMKOverlayView *)mapView:(YFTMKMapView *)mapView viewForOverlay:(id <YFTMKOverlay>)overlay;
- (void)mapView:(YFTMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews;


// iOS 4.0 additions:
- (void)mapView:(YFTMKMapView *)mapView didSelectAnnotationView:(YFTMKAnnotationView *)view;
- (void)mapView:(YFTMKMapView *)mapView didDeselectAnnotationView:(YFTMKAnnotationView *)view;
- (void)mapView:(YFTMKMapView *)mapView didUpdateUserLocation:(YFTMKUserLocation *)userLocation;
- (void)mapView:(YFTMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error;
- (void)mapViewWillStartLocatingUser:(YFTMKMapView *)mapView;
- (void)mapViewDidStopLocatingUser:(YFTMKMapView *)mapView;
- (void)mapView:(YFTMKMapView *)mapView annotationView:(YFTMKAnnotationView *)annotationView didChangeDragState:(YFTMKAnnotationViewDragState)newState fromOldState:(YFTMKAnnotationViewDragState)oldState;

// MacMapKit additions
- (void)mapView:(YFTMKMapView *)mapView userDidClickAndHoldAtCoordinate:(CLLocationCoordinate2D)coordinate;
- (NSArray *)mapView:(YFTMKMapView *)mapView contextMenuItemsForAnnotationView:(YFTMKAnnotationView *)view;

@end
