//
//  JUNViewController.m
//  JUNTableView
//
//  Created by Jun Ma on 11/23/2022.
//  Copyright (c) 2022 Jun Ma. All rights reserved.
//

#import "JUNViewController.h"
#import <JUNTableView/UITableView+JUNex.h>

@interface JUNViewController () <UITableViewDelegate>

@end

@implementation JUNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.text = @"aLabel";
    aLabel.textColor = [UIColor blackColor];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setTitle:@"aButton" forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UISwitch *aSwitch = [[UISwitch alloc] init];
    
    UITableView *tableView =
    [UITableView jun_tableViewWithItems:@[
        aLabel,
        aButton,
        aSwitch,
    ]];
    
    tableView.jun_alignment = -1;
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
}

@end
