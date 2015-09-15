//
//  MKPinAnnotationView.h
//  MapKit
//
//  Created by Rick Fillion on 7/18/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKAnnotationView.h>

enum {
    YFTMKPinAnnotationColorRed = 0,
    YFTMKPinAnnotationColorGreen,
    YFTMKPinAnnotationColorPurple
};
typedef NSUInteger YFTMKPinAnnotationColor;


@interface YFTMKPinAnnotationView : YFTMKAnnotationView
{
    YFTMKPinAnnotationColor pinColor;
    BOOL animatesDrop;
}

@property (nonatomic) YFTMKPinAnnotationColor pinColor;
@property (nonatomic) BOOL animatesDrop;

@end

