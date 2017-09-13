//
//  SecondTableViewCell.h
//  SmartCampus
//
//  Created by 芳坪梁 on 15/8/25.
//  Copyright (c) 2015年 芳坪梁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellUnit;
@property (weak, nonatomic) IBOutlet UITextField *tfNum;

- (NSString*)getContent;

@end
