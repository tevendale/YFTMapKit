//
//  MKCircleView.h
//  MapKit
//
//  Created by Rick Fillion on 7/12/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKOverlayPathView.h>

@class YFTMKCircle;

@interface YFTMKCircleView : YFTMKOverlayPathView {
    WebScriptObject *latlngCenter;
}

@property (nonatomic, readonly) YFTMKCircle *circle;

- (id)initWithCircle:(YFTMKCircle *)circle;



@end
