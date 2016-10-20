//
//  MainViewController.h
//  SIITev
//
//  Created by kitiya suriyachay on 10/19/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface MainViewController : UIViewController 
@property (strong, nonatomic) IBOutlet UILabel *nameDate;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIView *distance;
@property (strong, nonatomic) IBOutlet UIView *consumption;
@end
