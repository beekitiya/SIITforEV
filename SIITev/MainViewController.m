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

@interface MainViewController (){
    //Variable Section
    NSMutableString* dataBuffer;
    double sum_kWh;
    double sum_volt;
}
//UI Section
@property (strong, nonatomic) IBOutlet UILabel *statusBLE_data;
@property (strong, nonatomic) IBOutlet UILabel *airCon_data;
@property (strong, nonatomic) IBOutlet UILabel *kWh_data;
@property (strong, nonatomic) IBOutlet UILabel *gasCos_data;
@property (strong, nonatomic) IBOutlet UILabel *evCost_data;
@property (strong, nonatomic) IBOutlet UILabel *gasCost_data;
@property (strong, nonatomic) IBOutlet UILabel *evCo2_data;
@property (strong, nonatomic) IBOutlet UILabel *gasCo2_data;
//
@end

@implementation MainViewController

@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *todayDate, *todayTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"EEE, MMM dd, yyyy"];
    todayDate = [formatter stringFromDate:[NSDate date]];
    _date.text = todayDate;
    
    NSDateFormatter *formatterTime = [[NSDateFormatter alloc]init];
    [formatterTime setDateFormat:@"h:mm a"];
    todayTime = [formatterTime stringFromDate:[NSDate date]];
    _nameDate.text = todayTime;
    
    _consumption.layer.borderWidth = 1.0f;
    _consumption.layer.borderColor = [[UIColor colorWithRed:(104/255.0) green:(80/255.0) blue:(150/255.0) alpha:1.0]CGColor];
    
    _distance.layer.borderWidth = 1.0f;
    _distance.layer.borderColor = [[UIColor colorWithRed:(104/255.0) green:(80/255.0) blue:(150/255.0) alpha:1.0]CGColor];
    
    float viewWidth = self.EmissionPieChart.bounds.size.width / 2;
    float viewHeight = self.EmissionPieChart.bounds.size.height / 2;
    [self.EmissionPieChart setDelegate:self];
    [self.EmissionPieChart setDataSource:self];
    [self.EmissionPieChart setStartPieAngle:M_PI_2];
    [self.EmissionPieChart setAnimationSpeed:1.5];
    [self.EmissionPieChart setLabelColor:[UIColor whiteColor]];
    [self.EmissionPieChart setLabelShadowColor:[UIColor blackColor]];
    [self.EmissionPieChart setShowPercentage:YES];
    [self.EmissionPieChart setPieBackgroundColor:[UIColor clearColor]];
    
    
    //To make the chart at the center of view
    [self.EmissionPieChart setPieCenter:CGPointMake(self.EmissionPieChart.bounds.origin.x + viewWidth, self.EmissionPieChart.bounds.origin.y + viewHeight)];
    
    //Method to display the pie chart with values.
    [self.EmissionPieChart reloadData];
    
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
    
    //P'Top NSLog(@"Start BLE Initialize session");
    CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.centralManager = centralManager;
    sum_kWh = 0;
    dataBuffer = [[NSMutableString alloc] init];
    //END
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/*- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Add gradient background
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
    if(pieChart == self.EmissionPieChart){
        if(index % 2 == 0){
            value = 34;
        }
        else{
            value = 66;
        }
    }
    else{
        if(index % 2 == 0){
            value = 25;
        }
        else{
            value = 75;
        }
    }
    
    return value;
}

//Specify color for each sector
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    UIColor *color;
    if(pieChart == self.CostPieChart)
    {
        if(index%2 == 0) {
            color = [UIColor colorWithRed:(77/255.0) green:(126/255.0) blue:(236/255.0) alpha:1.0]; //EV
        } else {
            color = [UIColor colorWithRed:(212/255.0) green:(120/255.0) blue:(42/255.0) alpha:1.0]; //Gas
        }
    }
    else
    {
        if(index%2 == 0) {
            color = [UIColor colorWithRed:(77/255.0) green:(126/255.0) blue:(236/255.0) alpha:1.0]; //EV
        } else {
            color = [UIColor colorWithRed:(212/255.0) green:(120/255.0) blue:(42/255.0) alpha:1.0]; //Gas
        }
    }
    return color;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/* P'TOP Section */
- (void) UIManipulate:(CBCharacteristic *)characteristic {
    
    sum_kWh += kWh_cal(dataBuffer);
   
    NSString* kWh_buffer = [NSString stringWithFormat:@"%.3f", sum_kWh];
    NSString* cost_buffer = [NSString stringWithFormat:@"%.4f", sum_kWh * 4];
     NSLog(@"%@", cost_buffer);
    //UI Link
    _kWh_data.text = kWh_buffer;
    _evCost_data.text = cost_buffer;
    
    [self.peripheralManager setNotifyValue:YES forCharacteristic:characteristic];
}

- (void) centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"fail to connect!");
}

- (void) centralManagerDidUpdateState:(CBCentralManager *)central {
    // Determine the state of the peripheral and react accroding to state
    if ([central state] == CBManagerStatePoweredOff) {//[central state] = central.state
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBManagerStatePoweredOn) {
        NSArray *service = @[[CBUUID UUIDWithString:LAIRD_CONNECT_SERVICE_UUID]];
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
        [self.centralManager scanForPeripheralsWithServices:service options:nil]; //scan for device with specific UUID (service)
    }
    else if ([central state] == CBManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    //Discovered nearby device and stop scaning for deivce
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    NSLog(@"invoke");
    //Wait for target device disconvery, variable define in .h
    if ([localName length] > 0) {
        NSLog(@"Found : %@", localName);
        if([localName isEqualToString:@DEVICE_NAME]) {
            NSLog(@"Found Device : %@", localName);
            [self.centralManager stopScan]; //Stop scaning for device
            peripheral.delegate = self; //init peripheral instance
            
            
            NSLog(@"Try to connect to device");
            //Try to connect to device
            self.peripheralManager = peripheral; //init peripheral instance
            peripheral.delegate = self;
            [self.centralManager connectPeripheral:peripheral options:nil]; //conenct to target device EDITED
           
        }
    }
    
}

- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"connected");
     _statusBLE_data.text = @"Connected";
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
}

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for(CBService *service in peripheral.services) {
        NSLog(@"Discovery Sevices : %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"Start scaning for service");
    if([service.UUID isEqual:[CBUUID UUIDWithString:LAIRD_CONNECT_SERVICE_UUID]]) {
        
        for (CBCharacteristic *aChar in service.characteristics) {
            if([aChar.UUID isEqual:[CBUUID UUIDWithString:LAIRD_CHAR_NOTIFY_UUID]]) {
                NSLog(@"Found Notify characteristic");
                [peripheral setNotifyValue:YES forCharacteristic:aChar];
            }
            
            else if ([aChar.UUID isEqual:[CBUUID UUIDWithString:LAIRD_CHAR_WRITE_UUID]]){
                NSLog(@"Found Write chanracteristic");
                [peripheral setNotifyValue:NO forCharacteristic:aChar];
            }
        }
        
    }
}

- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSString* value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    if ( value != nil) {
        [dataBuffer appendString:value];
        //`NSLog(@"%@", dataBuffer);// Prtin Buffer
        
        //Find Battery information (Batt1 - 4)
        [self.peripheralManager setNotifyValue:NO forCharacteristic:characteristic];
        //NSLog(@"Manipulate kWh data label");
        [self UIManipulate:characteristic];
    }
}

NSArray* convertToArrayFromCommaSeparated(NSString*string){
    return [string componentsSeparatedByString:@"\n"];
    
    //How to call this method "convertToArrayFromCommaSeparated(contents);"
}

NSString*hexToBinary(NSString*hexString) {
    NSMutableString *retnString = [NSMutableString string];
    for(int i = 0; i < [hexString length]; i++) {
        char c = [[hexString lowercaseString] characterAtIndex:i];
        
        switch(c) {
            case '0': [retnString appendString:@"0000"]; break;
            case '1': [retnString appendString:@"0001"]; break;
            case '2': [retnString appendString:@"0010"]; break;
            case '3': [retnString appendString:@"0011"]; break;
            case '4': [retnString appendString:@"0100"]; break;
            case '5': [retnString appendString:@"0101"]; break;
            case '6': [retnString appendString:@"0110"]; break;
            case '7': [retnString appendString:@"0111"]; break;
            case '8': [retnString appendString:@"1000"]; break;
            case '9': [retnString appendString:@"1001"]; break;
            case 'a': [retnString appendString:@"1010"]; break;
            case 'b': [retnString appendString:@"1011"]; break;
            case 'c': [retnString appendString:@"1100"]; break;
            case 'd': [retnString appendString:@"1101"]; break;
            case 'e': [retnString appendString:@"1110"]; break;
            case 'f': [retnString appendString:@"1111"]; break;
            default : break;
        }
    }
    
    return retnString;
}

NSNumber * convertBinaryStringToDecimalNumber(NSString *binaryString) {
    NSUInteger totalValue = 0;
    for (int i = 0; i < binaryString.length; i++) {
        totalValue += (int)([binaryString characterAtIndex:(binaryString.length - 1 - i)] - 48) * pow(2, i);
    }
    return @(totalValue);
    
}
double convertBattInfo(NSString * battInfo, NSString * head) {
    double v,i;
    NSString *tempByte3th;
    NSString *tempByte2rd;
    
    if([battInfo length] == 27) {
        tempByte3th = [battInfo substringWithRange:NSMakeRange(13, 2)];
        tempByte2rd = [battInfo substringWithRange:NSMakeRange(10, 2)];
    }
    else {
        //NSLog(@"Insufficient information");
        return 0;
    }
    
    if ([head isEqualToString:@"501"]&&[battInfo length]==27){
        
        //        NSLog(@"Power(Batt 1) : %@ VA",convertBinaryStringToDecimalNumber( hexToBinary(tempByte2rd)));
        NSNumber *volt = convertBinaryStringToDecimalNumber( hexToBinary(tempByte3th));
        NSNumber *pow = convertBinaryStringToDecimalNumber( hexToBinary(tempByte2rd));
        v = 655.35* [volt floatValue] /255;
        i = [pow floatValue]/v;
        //        NSLog(@"Volt(Batt 1) : %f V ",v);
        //        NSLog(@"Amp(Batt 1) : %f A",i);
        //        NSLog(@"kWh(Batt 1) : %f Volt-Amp",i*v/1000/3600);
        
        
    }
    else if ([head isEqualToString:@"502"]&&[battInfo length]==27){
        
        
        //        NSLog(@"Power(Batt 2) : %@ VA",convertBinaryStringToDecimalNumber( hexToBinary(tempByte2rd)));
        NSNumber *volt = convertBinaryStringToDecimalNumber( hexToBinary(tempByte3th));
        NSNumber *pow = convertBinaryStringToDecimalNumber( hexToBinary(tempByte2rd));
        v = 655.35* [volt floatValue] /255;
        i = [pow floatValue]/v;
        //        NSLog(@"Volt(Batt 2) : %f ",v);
        //        NSLog(@"Amp(Batt 2) : %f ",i);
        //        NSLog(@"kWh(Batt 2) : %f ",i*v/1000/3600);
        // sum_kWh = sum_kWh+i*v/1000/3600;
    }
    else if ([head isEqualToString:@"503"]&&[battInfo length]==27){
        
        //        NSLog(@"Power(Batt 3) : %@ VA",convertBinaryStringToDecimalNumber( hexToBinary(tempByte2rd)));
        NSNumber *volt = convertBinaryStringToDecimalNumber( hexToBinary(tempByte3th));
        NSNumber *pow = convertBinaryStringToDecimalNumber( hexToBinary(tempByte2rd));
        v = 655.35* [volt floatValue] /255;
        i = [pow floatValue]/v;
        //        NSLog(@"Volt(Batt 3) : %f ",v);
        //        NSLog(@"Amp(Batt 3) : %f ",i);
        //        NSLog(@"kWh(Batt 3) : %f ",i*v/1000/3600);
        //sum_kWh = sum_kWh+i*v/1000/3600;
    }
    else if ([head isEqualToString:@"504"]&&[battInfo length]==27){
        
        
        //        NSLog(@"Power(Batt 4) : %@ VA",convertBinaryStringToDecimalNumber( hexToBinary(tempByte2rd)));
        NSNumber *volt = convertBinaryStringToDecimalNumber( hexToBinary(tempByte3th));
        NSNumber *pow = convertBinaryStringToDecimalNumber( hexToBinary(tempByte2rd));
        v = 655.35* [volt floatValue] /255;
        i = [pow floatValue]/v;
        //        NSLog(@"Volt(Batt 4) : %f ",v);
        //        NSLog(@"Amp(Batt 4) : %f ",i);
        //        NSLog(@"kWh(Batt 4) : %f ",i * v / 1000 / 3600);
        //sum_kWh = sum_kWh + i * v/ 1000 / 3600;
    }
    else{
        return 0;
    }
    
    //NSLog(@"-----");
    
    return v;
}

double kWh_cal(NSMutableString* package) {
    
    //Getting array from txt file
    //Put All Data in content (non-decode) *****************************
    NSString *contents = [NSString stringWithString:package];
    
    //init Mutable array name "arrayTemp"
    NSMutableArray *arrayTemp = [[NSMutableArray alloc] init];
    
    //Separate one line string by \n "new line symbol" from String to MutableArray
    arrayTemp = [[contents componentsSeparatedByString:@"\n"] mutableCopy];
    
    //        NSLog(@"After seperte new line: %@",arrayTemp);
    
    
    //Searching 504 from protocal to put in array of result
    NSString *stringToSearch = @"504";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",stringToSearch]; // if you need case sensitive search avoid '[c]' in the predicate
    NSArray *rawBatt4 = [arrayTemp filteredArrayUsingPredicate:predicate];
    stringToSearch = @"501";
    predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",stringToSearch]; // if you need case sensitive search avoid '[c]' in the predicate
    NSArray *rawBatt1 = [arrayTemp filteredArrayUsingPredicate:predicate];
    stringToSearch = @"502";
    predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",stringToSearch]; // if you need case sensitive search avoid '[c]' in the predicate
    NSArray *rawBatt2 = [arrayTemp filteredArrayUsingPredicate:predicate];
    stringToSearch = @"503";
    predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",stringToSearch]; // if you need case sensitive search avoid '[c]' in the predicate
    NSArray *rawBatt3 = [arrayTemp filteredArrayUsingPredicate:predicate];
    
    //Size of array
    
    
    NSUInteger sizerawBatt1  = [rawBatt1  count];
    NSUInteger sizerawBatt2  = [rawBatt2  count];
    NSUInteger sizerawBatt3  = [rawBatt3  count];
    NSUInteger sizerawBatt4  = [rawBatt4  count];
    
    NSUInteger min = sizerawBatt1;
    min = MIN(sizerawBatt1, sizerawBatt2 );
    min = MIN(min, sizerawBatt3);
    min = MIN(min, sizerawBatt4);
    //NSLog(@"the last one is %d",size);
    double temp;
    for (int i = 0 ; i <min;i++){
        
        // since convertBattInfo return Voltage value
        //sume of kWh =(0.02222222 * v * 0.5) / 1000 / 3600  //300ms interval
        
        temp += (0.02222222 *convertBattInfo(rawBatt1 [i],@"501")*0.5)/1000 /3600;
        temp += (0.02222222 *convertBattInfo(rawBatt2 [i],@"502")*0.5)/1000 /3600;
        temp += (0.02222222 *convertBattInfo(rawBatt3 [i],@"503")*0.5)/1000 /3600;
        temp += (0.02222222 *convertBattInfo(rawBatt4 [i],@"504")*0.5)/1000 /3600;
        
        
        
        //        NSLog(@"Power comsumption : %f kWh",sum_kWh);
        //        NSLog(@"cost : %f Bath",sum_kWh*4);
        //        NSLog(@"CO2(EV) emission : %f kg",(sum_kWh/10.28)*5.14);
        //        NSLog(@"CO2(Gasoline) emission : %f kg",(sum_kWh/10.28)*5.14*11.25);
        //        NSLog(@"***********************************");
    }
    return temp;
    
}

//END **************************************************************************************************



@end
