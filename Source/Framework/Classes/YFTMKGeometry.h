/*
 *  MKGeometry.h
 *  MapKit
 *
 *  Created by Rick Fillion on 7/11/10.
 *  Copyright 2010 Centrix.ca. All rights reserved.
 *
 */

#import <CoreLocation/CoreLocation.h>

typedef struct {
    CLLocationDegrees latitudeDelta;
    CLLocationDegrees longitudeDelta;
} YFTMKCoordinateSpan;

typedef struct {
    CLLocationCoordinate2D center;
    YFTMKCoordinateSpan span;
} YFTMKCoordinateRegion;


static inline YFTMKCoordinateSpan YFTMKCoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta)
{
    YFTMKCoordinateSpan span;
    span.latitudeDelta = latitudeDelta;
    span.longitudeDelta = longitudeDelta;
    return span;
}

static inline YFTMKCoordinateRegion YFTMKCoordinateRegionMake(CLLocationCoordinate2D centerCoordinate, YFTMKCoordinateSpan span)
{
    YFTMKCoordinateRegion region;
    region.center = centerCoordinate;
    region.span = span;
    return region;
}

// An MKMapPoint is a coordinate that has been projected for use on the
// two-dimensional map.  An MKMapPoint always refers to a place in the world
// and can be converted to a CLLocationCoordinate2D and back.
typedef struct {
    double x;
    double y;
} YFTMKMapPoint;

typedef struct {
    double width;
    double height;
} YFTMKMapSize;

typedef struct {
    YFTMKMapPoint origin;
    YFTMKMapSize size;
} YFTMKMapRect;

/*
// MKZoomScale provides a conversion factor between MKMapPoints and screen points.
// When MKZoomScale = 1, 1 screen point = 1 MKMapPoint.  When MKZoomScale is
// 0.5, 1 screen point = 2 MKMapPoints.
typedef CGFloat MKZoomScale;

// The map point for the coordinate (-90,180)
extern const MKMapSize MKMapSizeWorld;
// The rect that contains every map point in the world.
extern  const MKMapRect MKMapRectWorld;

 
// Conversion between unprojected and projected coordinates
extern  MKMapPoint MKMapPointForCoordinate(CLLocationCoordinate2D coordinate);
extern  CLLocationCoordinate2D MKCoordinateForMapPoint(MKMapPoint mapPoint);

// Conversion between distances and projected coordinates
extern  CLLocationDistance MKMetersPerMapPointAtLatitude(CLLocationDegrees latitude);
extern  double MKMapPointsPerMeterAtLatitude(CLLocationDegrees latitude);

extern  CLLocationDistance MKMetersBetweenMapPoints(MKMapPoint a, MKMapPoint b);

extern  const MKMapRect MKMapRectNull;*/

// Geometric operations on MKMapPoint/Size/Rect.  See CGGeometry.h for 
// information on the CGFloat versions of these functions.
static inline YFTMKMapPoint YFTMKMapPointMake(double x, double y) {
    return (YFTMKMapPoint){x, y};
}
static inline YFTMKMapSize YFTMKMapSizeMake(double width, double height) {
    return (YFTMKMapSize){width, height};
}

static inline YFTMKMapRect YFTMKMapRectMake(double x, double y, double width, double height) {
    return (YFTMKMapRect){ YFTMKMapPointMake(x, y), YFTMKMapSizeMake(width, height) };
}
static inline double YFTMKMapRectGetMinX(YFTMKMapRect rect) {
    return rect.origin.x;
}
static inline double YFTMKMapRectGetMinY(YFTMKMapRect rect) {
    return rect.origin.y;
}
static inline double YFTMKMapRectGetMidX(YFTMKMapRect rect) {
    return rect.origin.x + rect.size.width / 2.0;
}
static inline double YFTMKMapRectGetMidY(YFTMKMapRect rect) {
    return rect.origin.y + rect.size.height / 2.0;
}
static inline double YFTMKMapRectGetMaxX(YFTMKMapRect rect) {
    return rect.origin.x + rect.size.width;
}
static inline double YFTMKMapRectGetMaxY(YFTMKMapRect rect) {
    return rect.origin.y + rect.size.height;
}
static inline double YFTMKMapRectGetWidth(YFTMKMapRect rect) {
    return rect.size.width;
}
static inline double YFTMKMapRectGetHeight(YFTMKMapRect rect) {
    return rect.size.height;
}
static inline BOOL YFTMKMapPointEqualToPoint(YFTMKMapPoint point1, YFTMKMapPoint point2) {
    return point1.x == point2.x && point1.y == point2.y;
}
static inline BOOL YFTMKMapSizeEqualToSize(YFTMKMapSize size1, YFTMKMapSize size2) {
    return size1.width == size2.width && size1.height == size2.height;
}
static inline BOOL YFTMKMapRectEqualToRect(YFTMKMapRect rect1, YFTMKMapRect rect2) {
    return
    YFTMKMapPointEqualToPoint(rect1.origin, rect2.origin) &&
    YFTMKMapSizeEqualToSize(rect1.size, rect2.size);
}

static inline BOOL YFTMKMapRectIsNull(YFTMKMapRect rect) {
    return isinf(rect.origin.x) || isinf(rect.origin.y);
}
static inline BOOL YFTMKMapRectIsEmpty(YFTMKMapRect rect) {
    return YFTMKMapRectIsNull(rect) || (rect.size.width == 0.0 && rect.size.height == 0.0);
}

static inline NSString *YFTMKStringFromMapPoint(YFTMKMapPoint point) {
    return [NSString stringWithFormat:@"{%.1f, %.1f}", point.x, point.y];
}

static inline NSString *YFTMKStringFromMapSize(YFTMKMapSize size) {
    return [NSString stringWithFormat:@"{%.1f, %.1f}", size.width, size.height];
}

static inline NSString *YFTMKStringFromMapRect(YFTMKMapRect rect) {
    return [NSString stringWithFormat:@"{%@, %@}", YFTMKStringFromMapPoint(rect.origin), YFTMKStringFromMapSize(rect.size)];
}
/*
extern MKMapRect MKMapRectUnion(MKMapRect rect1, MKMapRect rect2);
extern MKMapRect MKMapRectIntersection(MKMapRect rect1, MKMapRect rect2);
extern MKMapRect MKMapRectInset(MKMapRect rect, double dx, double dy);
extern MKMapRect MKMapRectOffset(MKMapRect rect, double dx, double dy);
extern void MKMapRectDivide(MKMapRect rect, MKMapRect *slice, MKMapRect *remainder, double amount, CGRectEdge edge);

extern BOOL MKMapRectContainsPoint(MKMapRect rect, MKMapPoint point);
extern BOOL MKMapRectContainsRect(MKMapRect rect1, MKMapRect rect2);
extern BOOL MKMapRectIntersectsRect(MKMapRect rect1, MKMapRect rect2);

extern MKCoordinateRegion MKCoordinateRegionForMapRect(MKMapRect rect);

extern BOOL MKMapRectSpans180thMeridian(MKMapRect rect);
// For map rects that span the 180th meridian, this returns the portion of the rect
// that lies outside of the world rect wrapped around to the other side of the
// world.  The portion of the rect that lies inside the world rect can be 
// determined with MKMapRectIntersection(rect, MKMapRectWorld).
extern MKMapRect MKMapRectRemainder(MKMapRect rect);
 */
