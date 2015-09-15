//
//  MKWebView.m
//  MapKit
//
//  Created by Rick Fillion on 10-12-12.
//  Copyright 2010 Centrix.ca. All rights reserved.
//

#import "YFTMKWebView.h"


@implementation YFTMKWebView

@synthesize lastHitTestDate;


- (NSView *)hitTest:(NSPoint)aPoint
{
    //NSLog(@"hitTest: %@", NSStringFromPoint(aPoint));
    lastHitTestDate = [NSDate date];
    return [super hitTest:aPoint];
}

@end
