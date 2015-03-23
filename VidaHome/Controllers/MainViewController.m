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

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate> {
    CGFloat width, height;
}

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UITabBarController *tab;

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
    NSArray *list = [[NSArray alloc] initWithObjects:@"2998",@"2356",@"1548", @"1937", @"2466", @"2477", nil];
    self.dataList = list;
    
    [self buildUI];
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
    
    self.tab = [[UITabBarController alloc]init];
    
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
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
        if (indexPath.row < 4) {
            UISwitch *deviceSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(240, 0, 0, 0)];
            NSString *deviceId=self.dataList[indexPath.row];
            deviceSwitch.tag = [deviceId intValue];
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
    
    
    if (indexPath.row < 4) {
        title.text =[NSString stringWithFormat:@"Light %@", [self.dataList objectAtIndex:indexPath.row]];
        iconView.image = [UIImage imageNamed:@"LightCellOn"];
        secTitle.text = @"Turn off after 10 pm";
    } else if (indexPath.row == 4 || indexPath.row == 5) {
        title.text =[NSString stringWithFormat:@"Thermo %@", [self.dataList objectAtIndex:indexPath.row]];
        iconView.image = [UIImage imageNamed:@"ThermoCellOn"];
        secTitle.text = @"Reach setting temp. in 1 hr";
    } else if (indexPath.row == 6) {
        title.text = @"Beacon";
        secTitle.text = @"Click to turn on Beacon";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row < 4) {
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
    }
}


-(void)toggleLight:(UISwitch *)sender
{
    BOOL isOn;
    if (sender.isOn) {
        isOn = YES;
    } else {
        isOn = NO;
    }
    NSString *deviceId = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    [[NetworkManager sharedInstance] postRequest:@"light" parameters:@{@"deviceId":deviceId,@"ON":@(isOn), @"color":@"ffffff"} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}
@end
