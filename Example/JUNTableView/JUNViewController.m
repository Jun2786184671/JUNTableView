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
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 1000)];
    aView.backgroundColor = [UIColor orangeColor];
    
    UITableView *tableView =
//    [UITableView jun_tableViewWithItems:@[
//        aLabel,
//        aButton,
//        aSwitch,
//        aView,
//    ]];
//    tableView.rowHeight = 20;
    
    [UITableView jun_tableViewWithItemCount:20 itemBuilder:^UIView * _Nonnull(NSUInteger index) {
        UILabel *aLabel = [[UILabel alloc] init];
        aLabel.text = [NSString stringWithFormat:@"label%lu", index];
        aLabel.textColor = [UIColor blackColor];
        return aLabel;
    }];
    
    tableView.jun_alignment = -1;
//    tableView.frame = self.view.bounds;
    tableView.frame = CGRectMake(0, 0, 100, 300);
    tableView.backgroundColor = [UIColor yellowColor];
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
