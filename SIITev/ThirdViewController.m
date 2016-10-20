//
//  ThirdViewController.m
//  SIITev
//
//  Created by kitiya suriyachay on 10/18/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import "ThirdViewController.h"
#import "BackgroundLayer.h"
#import <QuartzCore/QuartzCore.h>
#import "WaterProgress.h"

@interface ThirdViewController ()
@property (nonatomic) BOOL isAnimating;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *todayDate, *todayTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd, yyyy h:mm a"];
    todayDate = [formatter stringFromDate:[NSDate date]];
    _date.text = todayDate;
    
    NSDateFormatter *formatterTime = [[NSDateFormatter alloc]init];
    [formatterTime setDateFormat:@"EEEE"];
    todayTime = [formatterTime stringFromDate:[NSDate date]];
    _nameDate.text = todayTime;
    
    /*self.waterView = [[WaterProgress alloc] initWithFrame:self.view.bounds];
    self.waterView.center = self.view.center;
    [self.view addSubview:self.waterView];*/
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateAnimation)];
    [self.waterView addGestureRecognizer:gesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(updatePercent:)];
    [self.waterView addGestureRecognizer:panGesture];
    
    self.isAnimating = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Add gradient background
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void)updatePercent:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [gesture locationInView:self.waterView];
        NSUInteger percent = 100 - 100 * location.y / CGRectGetHeight(self.waterView.bounds);
        [self.waterView updateWithPercentCompletion:percent];
    }
}

- (void)updateAnimation
{
    self.isAnimating = !self.isAnimating;
    if (self.isAnimating) {
        [self.waterView startAnimation];
    } else {
        [self.waterView stopAnimation];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
