//
//  FirstTableViewController.m
//  SmartCampus
//
//  Created by 芳坪梁 on 15/8/25.
//  Copyright (c) 2015年 芳坪梁. All rights reserved.
//

#import "FirstTableViewController.h"
#import "SecondTableViewController.h"


@interface FirstTableViewController ()

@end

@implementation FirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"first" ofType:@"plist"];
    _firstItemArray = [[NSArray alloc] initWithContentsOfFile:path];
    
//    for (int i=0; i<_firstItemArray.count; i++) {
//        NSLog(@"itemName=@%@",_firstItemArray[i]);
//    }
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _firstItemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSUInteger row = [indexPath row];
    NSDictionary *goodsDic = [_firstItemArray objectAtIndex:row];
    cell.textLabel.text =  [goodsDic objectForKey:@"goods_name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *goodsDic = [_firstItemArray objectAtIndex:[indexPath row]];

    SecondTableViewController *secondTable = [[SecondTableViewController alloc] init];
    secondTable.infoDic = goodsDic;
    secondTable.infoIndex = [indexPath row];
    [self.navigationController pushViewController:secondTable animated:YES];
    
}


@end
