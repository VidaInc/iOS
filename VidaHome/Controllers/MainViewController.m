//
//  MainViewController.m
//  VidaHome
//
//  Created by olivia yang on 2015-01-27.
//  Copyright (c) 2015 Vida. All rights reserved.
//

#import "MainViewController.h"
#import "BeaconViewController.h"


@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate> {
    CGFloat width, height;
}

@property (nonatomic) UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"navigationSB"];
    UIImage *navTiltle = [UIImage imageNamed:@"navigationTitle"];
    [ApplicationStyle customizeLeftButton:self hander:nil withImage:image];
    [ApplicationStyle customizeTitle:self withImage:navTiltle];
    NSArray *list = [[NSArray alloc] initWithObjects:@"Ceiling Light 1", @"Thermo", @"Floor Light 1", @"iBeacon", nil];
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
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
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
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 160, 30)];
    title.text = [self.dataList objectAtIndex:indexPath.row];
    title.font = [ApplicationStyle cellTextFont];
    [cell.contentView addSubview:title];
    
    UILabel *secTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 55, 160, 15)];
    secTitle.font = [ApplicationStyle cellsecondTitleFont];
    secTitle.textColor = [ApplicationStyle cellOffTextColor];
    [cell.contentView addSubview:secTitle];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 45, 45)];
    [iconView centerInHeight:92];
    
    UISwitch *deviceSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(240, 0, 0, 0)];
    [deviceSwitch centerInHeight:92];
    [cell.contentView addSubview:deviceSwitch];
    
    if (indexPath.row == 0) {
        iconView.image = [UIImage imageNamed:@"LightCellOn"];
        secTitle.text = @"Turn off after 10 pm";
        [deviceSwitch addTarget:self action:@selector(toggleLight:) forControlEvents:UIControlEventValueChanged];
    } else if (indexPath.row == 1) {
        iconView.image = [UIImage imageNamed:@"ThermoCellOn"];
        secTitle.text = @"Reach setting temp. in 1 hr";
        UILabel *temp = [[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, 92)];
        temp.text = @"22°C";
        temp.font = [ApplicationStyle cellTempFont];
        temp.textColor = [ApplicationStyle cellBlurColor];
        //[cell.contentView addSubview:temp];
    } else if (indexPath.row == 2) {
        //[[cell contentView] setBackgroundColor:[ApplicationStyle backgroundColor]];
        //[title setTextColor:[ApplicationStyle cellOffTextColor]];
        iconView.image = [UIImage imageNamed:@"FloorCellOn"];
        secTitle.text = @"Turn on after 10 pm";
        [deviceSwitch addTarget:self action:@selector(toggleLight:) forControlEvents:UIControlEventValueChanged];
    } else if (indexPath.row == 3) {
        secTitle.text = @"Click to turn on Beacon";
    }
    [cell.contentView addSubview:iconView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 3) {
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
    
    [[NetworkManager sharedInstance] postRequest:@"light/1" parameters:@{@"ON":@(isOn), @"color":@"ffffff" } success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}
@end
