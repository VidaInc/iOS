//
//  MainViewController.m
//  VidaHome
//
//  Created by olivia yang on 2015-01-27.
//  Copyright (c) 2015 Vida. All rights reserved.
//

#import "MainViewController.h"
#import "BeaconViewController.h"
#import "ColorPickerViewController.h"
#import "ACViewController.h"
#import "LightViewController.h"
#import "ABBeaconManager.h"
#import "ABBeacon.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate, ABBeaconManagerDelegate> {
    CGFloat width, height;
}

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UITabBarController *tab;
@property (nonatomic) NSArray *ABBeacons;
//@property (nonatomic) ABLightManager *lightManager;
@property BOOL selectedLightOn;
@property (nonatomic, strong) ABBeaconManager *beaconManager;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"navigationSB"];
    UIImage *navRight = [UIImage imageNamed:@"navigationRight"];
    UIImage *navTiltle = [UIImage imageNamed:@"navigationTitle"];
    [ApplicationStyle customizeLeftButton:self hander:nil withImage:image];
    [ApplicationStyle customizeRightButton:self hander:nil withImage:navRight];
    [ApplicationStyle customizeTitle:self withImage:navTiltle];
    //NSArray *list = [[NSArray alloc] initWithObjects:@"2998",@"2356",@"1548", @"1937", @"2466", @"2477", nil];
    //self.lightManager = [ABLightManager new];
    //self.lightManager.delegate = self;
    self.beaconManager = [[ABBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    [self buildUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.lightManager startDiscoverLight];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                     target:self
                                                   selector:@selector(runLoopStartScan)
                                                   userInfo:nil
                                                    repeats:YES];
    [timer fire];
}

/*-(void)lightManager:(ABLightManager *)manager didDiscoverLights:(NSArray *)lights
{
    if ([lights count]>0) {
        
    }
}*/

- (void)runLoopStartScan {
    [self.beaconManager stopAprilBeaconDiscovery];
    [self.beaconManager startAprilBeaconsDiscovery];
}

- (void)buildUI
{
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setBackgroundColor:[ApplicationStyle backgroundColor]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    //self.tab = [[UITabBarController alloc]init];
    
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.ABBeacons count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel *title, *secTitle;
    UIImageView *iconView;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        title = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 160, 30)];
        title.font = [ApplicationStyle cellTextFont];
        [cell.contentView addSubview:title];
        
        secTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 55, 160, 15)];
        secTitle.font = [ApplicationStyle cellsecondTitleFont];
        secTitle.textColor = [ApplicationStyle cellOffTextColor];
        [cell.contentView addSubview:secTitle];
        
        iconView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 45, 45)];
        [iconView centerInHeight:92];
        [cell.contentView addSubview:iconView];
        /*if (indexPath.row < 4) {
            UISwitch *deviceSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(240, 0, 0, 0)];
            
            deviceSwitch.tag = indexPath.row;
            [deviceSwitch centerInHeight:92];
            [deviceSwitch addTarget:self action:@selector(toggleLight:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:deviceSwitch];
        } else if (indexPath.row == 4 || indexPath.row == 5) {
            UILabel *temp = [[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, 92)];
            temp.text = @"22°C";
            temp.font = [ApplicationStyle cellTempFont];
            temp.textColor = [ApplicationStyle cellBlurColor];
            [cell.contentView addSubview:temp];
        }
        else if (indexPath.row > 6) {
            UISwitch *deviceSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(240, 0, 0, 0)];
           /// NSString *deviceId=self.dataList[indexPath.row];
            deviceSwitch.tag = indexPath.row-7;
            [deviceSwitch centerInHeight:92];
            [deviceSwitch addTarget:self action:@selector(toggleLight:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:deviceSwitch];
        }*/
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    //if (indexPath.row) {
    ABBeacon *beacon = self.ABBeacons[indexPath.row];
    title.text =beacon.peripheral.identifier.UUIDString;//[NSString stringWithFormat:@"Light %ld", (long)indexPath.row];
    iconView.image = [UIImage imageNamed:@"LightCellOn"];
    secTitle.text = [NSString stringWithFormat:@"%ld", (long)beacon.rssi];
    /*} else if (indexPath.row == 4 || indexPath.row == 5) {
        title.text =[NSString stringWithFormat:@"Thermo %@", [self.dataList objectAtIndex:indexPath.row]];
        iconView.image = [UIImage imageNamed:@"ThermoCellOn"];
        secTitle.text = @"Reach setting temp. in 1 hr";
    } else if (indexPath.row == 6) {
        title.text = @"Beacon";
        secTitle.text = @"Click to turn on Beacon";
    }
    else if (indexPath.row > 6) {
        //get the light from ABLightManager
        title.text = @"lightnew";
        iconView.image = [UIImage imageNamed:@"LightCellOn"];
        secTitle.text = @"Turn off after 11 pm";

    }*/
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ABBeacon *beacon = self.ABBeacons[indexPath.row];
    LightViewController *lightController = [LightViewController new];
    lightController.beacon = beacon;
    [self.navigationController pushViewController:lightController animated:YES];
    /*if (indexPath.row < 4) {
        ColorPickerViewController *vc = [ColorPickerViewController new];
        vc.lightId = self.dataList[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4 || indexPath.row == 5) {
        ACViewController *vc = [ACViewController new];
        vc.thermoId = self.dataList[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 6) {
        BeaconViewController *beaconController = [BeaconViewController new];
        [self.navigationController pushViewController:beaconController animated:YES];
    } else if (indexPath.row > 7 ){
        //get the data from ABLightManager
        //LightViewController *lightController = [LightViewController new];
        
        //[self.navigationController pushViewController:lightController animated:(YES)];
    }*/
}

#pragma mark - ABBeaconManagerDelegate
- (void)beaconManager:(ABBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons{
    self.ABBeacons = beacons;
    [self.tableView reloadData];
    NSMutableArray *requestArray = [NSMutableArray new];
    for (ABBeacon *beacon in beacons) {
        if ([beacon.peripheral.identifier.UUIDString isEqualToString:@"E3138FB9-E229-EF15-A8C7-B15B09BFDC0D"]) {
            NSDictionary *beaconDic = @{@"userId":[ApplicationStyle getUserId],@"UUID":@(0), @"major":@(0),@"minor":@(1), @"rssi":@(beacon.rssi), @"MACaddr":@"B4-99-4C-89-70-53"};
            [requestArray addObject:beaconDic];
        } else if ([beacon.peripheral.identifier.UUIDString isEqualToString:@"E14E9179-457B-7E60-C069-91BBD7DAA9C8"]) {
            NSDictionary *beaconDic = @{@"userId":[ApplicationStyle getUserId],@"UUID":@(0), @"major":@(0),@"minor":@(3), @"rssi":@(beacon.rssi), @"MACaddr":@"B4-99-4C-89-72-9E"};
            [requestArray addObject:beaconDic];
        } else {
            NSDictionary *beaconDic = @{@"userId":[ApplicationStyle getUserId],@"UUID":@(0), @"major":@(0),@"minor":@(2), @"rssi":@(beacon.rssi), @"MACaddr":@"D0-FF-50-67-7C-4A"};
            [requestArray addObject:beaconDic];
        }
    }
    [[NetworkManager sharedInstance] postRequest:@"" parameters:@{@"beacons":requestArray} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}
@end
