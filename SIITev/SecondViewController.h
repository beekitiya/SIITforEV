//
//  SecondViewController.h
//  SIITev
//
//  Created by kitiya suriyachay on 10/16/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface SecondViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource>

@property (weak, nonatomic) IBOutlet XYPieChart *CostPieChart;
@property (strong, nonatomic) IBOutlet UIView *CostGas;
@property (strong, nonatomic) IBOutlet UIView *CostEV;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;
@end

