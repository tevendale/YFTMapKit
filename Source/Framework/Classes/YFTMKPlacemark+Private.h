//
//  MKPlacemark+Private.h
//  MapKit
//
//  Created by Rick Fillion on 7/26/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKPlacemark.h>

@interface YFTMKPlacemark (Private)

-(id)initWithGoogleGeocoderResult:(NSDictionary *)result;

@end
