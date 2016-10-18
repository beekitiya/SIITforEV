//
//  FirstViewController.h
//  SIITev
//
//  Created by kitiya suriyachay on 10/16/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface FirstViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource>
@property (weak, nonatomic) IBOutlet XYPieChart *CO2PieChart;
@property (weak, nonatomic) IBOutlet UIView *EmissionGas;
@property (weak, nonatomic) IBOutlet UIView *EmissionElec;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

@end

