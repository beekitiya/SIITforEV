//
//  BackgroundLayer.m
//  SIIT EV
//
//  Created by kitiya suriyachay on 10/5/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import "BackgroundLayer.h"
#import <UIKit/UIKit.h>

@implementation BackgroundLayer

//Blue gradient background
+ (CAGradientLayer*) blueGradient {
    UIColor *colorOne = [UIColor colorWithRed:(143/255.0) green:(75/255.0) blue:(221/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(54/255.0)  green:(127/255.0)  blue:(201/255.0)  alpha:1.0];
    //UIColor *colorThree = [UIColor colorWithRed:(70/255.0)  green:(161/255.0)  blue:(221/255.0)  alpha:1.0];
    //UIColor *colorFour = [UIColor colorWithRed:(82/255.0)  green:(209/255.0)  blue:(234/255.0)  alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    //NSNumber *stopThree = [NSNumber numberWithFloat:0.7];
    //NSNumber *stopFour = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

@end
