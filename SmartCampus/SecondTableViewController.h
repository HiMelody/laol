//
//  SecondTableViewController.h
//  SmartCampus
//
//  Created by 芳坪梁 on 15/8/25.
//  Copyright (c) 2015年 芳坪梁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SecondTableViewController : UITableViewController <UITextFieldDelegate,MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong,nonatomic) NSDictionary *infoDic;
@property (assign,nonatomic) int infoIndex;

@end
