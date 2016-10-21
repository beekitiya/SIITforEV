//
//  MainViewController.h
//  SIITev
//
//  Created by kitiya suriyachay on 10/19/2559 BE.
//  Copyright © 2559 kitiya suriyachay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

/* Define service and characteristic UUID for BLE LT600 Laird Virtual Serial Port (vSP) service for BL600 http://www.lairdtech.com/DownloadAsset.aspx?id=2147489885*/
#define LAIRD_CONNECT_SERVICE_UUID                      @"569a1101-b87f-490c-92cb-11ba5ea5167c"
#define LAIRD_CHAR_NOTIFY_UUID                          @"569a2000-b87f-490c-92cb-11ba5ea5167c"
#define LAIRD_CHAR_WRITE_UUID                           @"569a2001-b87f-490c-92cb-11ba5ea5167c"

#define ADAFRUIT_SERVICE_UUID                           @"FFE0"
#define ADAFRUIT_READ_WRITE_UUID                        @"FFE1"
//#define ADAFRUIT_SERVICE_UUID                           "A5EF8ACC-F471-4388-A930-D1978B11A675"

/* Define device name, reconfigurable accrodingly to device name. */
#define DEVICE_NAME                                     "LT_UPASS"
#define TEST_DEVICE_NAME                                "HMSoft"

@import CoreBluetooth;
@import QuartzCore;


@interface MainViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource, CBCentralManagerDelegate, CBPeripheralDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameDate;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIView *distance;
@property (strong, nonatomic) IBOutlet UIView *consumption;

@property (strong, nonatomic) IBOutlet XYPieChart *EmissionPieChart;
@property (strong, nonatomic) IBOutlet XYPieChart *CostPieChart;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;


@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheralManager;

- (void) UIManipulate:(CBCharacteristic*)characteristic;
@end
