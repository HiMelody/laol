//
//  WXManager.h
//  SmartCampus
//
//  Created by 芳坪梁 on 16/9/9.
//  Copyright © 2016年 芳坪梁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"

@protocol WXManagerDelegate <NSObject>

@optional

/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onWXReq:(BaseReq*)req;



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onWXResp:(BaseResp*)resp;

@end

@interface WXManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<WXManagerDelegate> delegate;

+ (instancetype)shareManager;

@end
