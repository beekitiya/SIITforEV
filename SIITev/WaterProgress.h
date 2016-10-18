//
//  WaterProgress.h
//  SIITev
//
//  Created by kitiya suriyachay on 10/19/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>

@interface WaterProgress : UIView

/**
 * Update the percent of completion
 */
- (void)updateWithPercentCompletion:(NSUInteger)percent;

/**
 * Start animation
 */
- (void)startAnimation;

/**
 * Stop animation
 */
- (void)stopAnimation;

/*
 * Percent of completion
 * Default: 0
 */
@property (nonatomic, readonly) IBInspectable NSUInteger completionInPercent;

/*
 * Font size used to display the text of completionInPercent.
 * Default: 20.0f
 */
@property (nonatomic) IBInspectable CGFloat fontSize;

/*
 * Color to use when drawing the waves
 * Default: cyan
 */
@property (nonatomic, strong) IBInspectable UIColor *waveColor;


@end
