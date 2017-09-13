//
//  SecondTableViewCell.m
//  SmartCampus
//
//  Created by 芳坪梁 on 15/8/25.
//  Copyright (c) 2015年 芳坪梁. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

- (void)awakeFromNib {
    _tfNum.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

-(NSString *)getContent{
    //    NSLog(@"cell=%@",[NSString stringWithFormat:@"%@%@%@,",self.name,self.num,self.unit]);
    self.tfNum.text = [self.tfNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(self.tfNum.text.length > 0){
        return [NSString stringWithFormat:@"%@%@%@,",self.cellName.text,self.tfNum.text,self.cellUnit.text];
    }else{
        return @"";
        
    }
}


@end
