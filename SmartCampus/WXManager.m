//
//  WXManager.m
//  SmartCampus
//
//  Created by 芳坪梁 on 16/9/9.
//  Copyright © 2016年 芳坪梁. All rights reserved.
//

#import "WXManager.h"

@implementation WXManager

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static WXManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXManager alloc] init];
    });
    
    return instance;
}


#pragma mark -- WXApiDelegate

- (void)onReq:(BaseReq *)req{
    [self.delegate onWXReq:req];
}


- (void)onResp:(BaseResp *)resp{
    [self.delegate onWXResp:resp];
}

@end
