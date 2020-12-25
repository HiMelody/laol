//
//  SecondTableViewController.m
//  SmartCampus
//
//  Created by 芳坪梁 on 15/8/25.
//  Copyright (c) 2015年 芳坪梁. All rights reserved.
//

#import "SecondTableViewController.h"
#import "SecondTableViewCell.h"
#import "LLLDefine.h"
#import <WechatOpenSDK/WXApi.h>


@interface SecondTableViewController()

@property (strong,nonatomic) NSString *goodsName;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSArray *infoArray;
@property (strong,nonatomic) NSMutableArray *cellArray;
@property (strong,nonatomic) UITextField *currentTf;

@end

@implementation SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];

}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infoArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"SecondTableViewCell";
//    SecondTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        [tableView registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
//        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        cell.tfNum.delegate = self;
//    }
  
    NSUInteger row = [indexPath row];
    SecondTableViewCell *cell = _cellArray[row];

    return cell;
}


//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    _currentTf = textField;
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}




- (void)initData{
    _goodsName = [_infoDic valueForKey:@"goods_name"];
    
    NSString *tmpPhone = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@%d",PhoneKey,_infoIndex]];
    if (tmpPhone) {
        _phone = tmpPhone;
    }else {
        _phone = [_infoDic valueForKey:@"goods_phone"];
    }
    
    
    _infoArray = [_infoDic valueForKey:@"goods_info"];
    
    _cellArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i=0; i<_infoArray.count; i++) {
        
        NSDictionary *infoDic = _infoArray[i];
        
        SecondTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SecondTableViewCell" owner:nil options:nil] objectAtIndex:0];
        cell.cellName.text = [infoDic objectForKey:@"info_name"];
        cell.cellUnit.text = [infoDic objectForKey:@"info_unit"];

        [_cellArray addObject:cell];
    }
}

- (void)initUI{
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@  %@",_goodsName,_phone]];
    
    UIBarButtonItem *changePhoneItem = [[UIBarButtonItem alloc] initWithTitle:@"改" style:UIBarButtonItemStylePlain target:self action:@selector(changePhone)];
    [changePhoneItem setTintColor:[UIColor redColor]];
    
    UIBarButtonItem *wxItem = [[UIBarButtonItem alloc] initWithTitle:@"微信" style:UIBarButtonItemStylePlain target:self action:@selector(sendWX)];
    
    self.navigationItem.rightBarButtonItems = @[
                                               [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendSms)],
                                               changePhoneItem,
                                               wxItem
                                               ];

    
}

/**
 *  发送短信
 */
- (void)sendSms{

    NSString *sms = [[NSString alloc] init];
    for (int i=0; i < _cellArray.count; i++) {
        SecondTableViewCell *cell = [_cellArray objectAtIndex:i];
        if(cell != nil){
            sms = [sms stringByAppendingString:[cell getContent]];
        }
        
        
    }
    
    if(sms.length > 0){
        sms = [sms substringToIndex:sms.length-1];
        NSLog(@"%@",sms);
        [self showMessageView:sms andPhone:_phone];
    }
    
    
}


- (void)sendWX{
    NSString *sms = [[NSString alloc] init];
    for (int i=0; i < _cellArray.count; i++) {
        SecondTableViewCell *cell = [_cellArray objectAtIndex:i];
        if(cell != nil){
            sms = [sms stringByAppendingString:[cell getContent]];
        }
    }
    
    [UIPasteboard generalPasteboard].string = sms;
    if(sms.length > 0){
        if ([WXApi isWXAppInstalled]) {
            sms = [sms substringToIndex:sms.length-1];
            NSLog(@"%@",sms);
            SendMessageToWXReq *reqMsg = [[SendMessageToWXReq alloc] init];
            reqMsg.bText = YES;
            reqMsg.text = sms;
            reqMsg.scene = WXSceneSession;
            [WXApi sendReq:reqMsg];
//            [WXApi sendReq:reqMsg completion:^(BOOL success) {
//                NSLog(@"success=%@",success?@"true":@"false");
//            }];
        }
        
    }
}


- (void)changePhone{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改联系人" message:[NSString stringWithFormat:@"当前:(%@)%@",_goodsName,_phone] preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *phoneTextField = alertController.textFields.firstObject;
        NSString *phoneText = phoneTextField.text;
        if (phoneText) {
            phoneText = [phoneText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([phoneText isEqualToString:@""]) {
                [self alertWithTitle:@"提示" msg:@"修改失败,输入的手机号码为空,请重新操作"];
                return ;
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:phoneText forKey:[NSString stringWithFormat:@"%@%d",PhoneKey,_infoIndex]];
            _phone = phoneText;
            [self.navigationItem setTitle:[NSString stringWithFormat:@"%@  %@",_goodsName,_phone]];
            
            [self alertWithTitle:@"提示" msg:[NSString stringWithFormat:@"修改成功\n(%@)%@",_goodsName,_phone]];
        }

    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新的手机号码";
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }];
    
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)showMessageView:(NSString*)content andPhone:(NSString*)phone
{
    
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:phone];
        controller.body = content;
        controller.messageComposeDelegate = self;
        
//        [self.navigationController pushViewController:controller animated:YES];
        [self presentModalViewController:controller animated:YES];
    }else{
    
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
        NSLog(@"设备没有短信功能");
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissModalViewControllerAnimated:NO];
    
    switch ( result ) {
            
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MessageComposeResultFailed:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        default:
            break;
    }
    
}


- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];  
    
}


#pragma mark -- WXApiDelegate

- (void)onReq:(BaseReq *)req{
    NSLog(@"onReq");
}

- (void)onResp:(BaseResp *)resp{
    NSLog(@"onResp");
}

@end
