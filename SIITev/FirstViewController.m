//
//  FirstViewController.m
//  SIITev
//
//  Created by kitiya suriyachay on 10/16/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import "FirstViewController.h"
#import "BackgroundLayer.h"
#import <QuartzCore/QuartzCore.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float viewWidth = self.CO2PieChart.bounds.size.width / 2;
    float viewHeight = self.CO2PieChart.bounds.size.height / 2;
    [self.CO2PieChart setDelegate:self];
    [self.CO2PieChart setDataSource:self];
    [self.CO2PieChart setStartPieAngle:M_PI_2];
    [self.CO2PieChart setAnimationSpeed:1.5];
    [self.CO2PieChart setLabelColor:[UIColor whiteColor]];
    [self.CO2PieChart setLabelShadowColor:[UIColor blackColor]];
    [self.CO2PieChart setShowPercentage:YES];
    [self.CO2PieChart setPieBackgroundColor:[UIColor clearColor]];
    
    
    //To make the chart at the center of view
    [self.CO2PieChart setPieCenter:CGPointMake(self.CO2PieChart.bounds.origin.x + viewWidth, self.CO2PieChart.bounds.origin.y + viewHeight)];
    
    //Method to display the pie chart with values.
    [self.CO2PieChart reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidLayoutSubviews {

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
        value = 34;
    }
    else
    {
        value = 66;
    }
    return value;
}

//Specify color for each sector
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    UIColor *color;
    if(index%2 == 0)
    {
        color = [UIColor redColor];
    }
    else
    {
        color = [UIColor greenColor];
    }
    return color;
}

@end
