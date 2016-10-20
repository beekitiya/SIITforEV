//
//  MainViewController.m
//  SIITev
//
//  Created by kitiya suriyachay on 10/19/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import "MainViewController.h"
#import "BackgroundLayer.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()

@end

@implementation MainViewController

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
