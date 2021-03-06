//
//  MKShape.h
//  MapKit
//
//  Created by Rick Fillion on 7/12/10.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <YFTMapKit/YFTMKAnnotation.h>

@interface YFTMKShape : NSObject <YFTMKAnnotation> {
    @package
    NSString *title;
    NSString *subtitle;
}

@property (copy) NSString *title;
@property (copy) NSString *subtitle;


@end
