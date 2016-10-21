//
//  DrawViewController.m
//  SIITev
//
//  Created by kitiya suriyachay on 10/21/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import "DrawViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DrawViewController

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //Get the CGContext from this view
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //Set the width of the pen mark
    CGContextSetLineWidth(context, 3.0);
    
    // Draw a line
    //Start at this point
    CGContextMoveToPoint(context, 20.0, 180.0); //(x,y)
    
    //Give instructions to the CGContext
    //(move "pen" around the screen)
    CGContextAddLineToPoint(context, 100.0, 80.0);
    
    //Draw it
    CGContextStrokePath(context);
}


@end
