//
//  SecondViewController.m
//  SIITev
//
//  Created by kitiya suriyachay on 10/16/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import "SecondViewController.h"
#import "BackgroundLayer.h"
#import <QuartzCore/QuartzCore.h> 

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float viewWidth = self.CostPieChart.bounds.size.width / 2;
    float viewHeight = self.CostPieChart.bounds.size.height / 2;
    [self.CostPieChart setDelegate:self];
    [self.CostPieChart setDataSource:self];
    [self.CostPieChart setStartPieAngle:M_PI_2];
    [self.CostPieChart setAnimationSpeed:1.5];
    [self.CostPieChart setLabelColor:[UIColor whiteColor]];
    [self.CostPieChart setLabelShadowColor:[UIColor blackColor]];
    [self.CostPieChart setShowPercentage:YES];
    [self.CostPieChart setPieBackgroundColor:[UIColor clearColor]];
    
    
    //To make the chart at the center of view
    [self.CostPieChart setPieCenter:CGPointMake(self.CostPieChart.bounds.origin.x + viewWidth, self.CostPieChart.bounds.origin.y + viewHeight)];
    
    //Method to display the pie chart with values.
    [self.CostPieChart reloadData];
   
    _CostGas.layer.borderWidth = 1.0f;
    _CostGas.layer.borderColor = [[UIColor colorWithRed:(245/255.0) green:(190/255.0) blue:(88/255.0) alpha:1.0]CGColor];
    
    _CostEV.layer.borderWidth = 1.0f;
    _CostEV.layer.borderColor = [[UIColor colorWithRed:(7/255.0) green:(158/255.0) blue:(166/255.0) alpha:1.0]CGColor];
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

//Specify the number of Sectors in the chart
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return 2;
}
//Specify the Value for each sector
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    CGFloat value = 0.0;
    if(index % 2 == 0)
    {
        value = 20;
    }
    else
    {
        value = 80;
    }
    return value;
}

//Specify color for each sector
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    UIColor *color;
    if(index%2 == 0)
    {
        color = [UIColor colorWithRed:(7/255.0) green:(158/255.0) blue:(166/255.0) alpha:1.0];
    }
    else
    {
        color = [UIColor colorWithRed:(245/255.0) green:(190/255.0) blue:(88/255.0) alpha:1.0];
    }
    return color;
}

@end
