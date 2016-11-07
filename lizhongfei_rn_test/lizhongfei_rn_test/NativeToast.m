//
//  NativeToast.m
//  lizhongfei_rn_test
//
//  Created by lizhongfei on 3/11/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

#import "NativeToast.h"
#import "RCTEventDispatcher.h"

#define TOAST_FONT_SIZE  14
#define TOAST_MAX_WIDTH 375
#define TOAST_MAX_HEIGHT 667
#define TOAST_MIN_HEIGHT 100
#define TOAST_MIN_WIDTH  100



@implementation NativeToast
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

#pragma mark -iOS native

RCT_EXPORT_METHOD(showMessage:(NSString *)message showTime:(NSInteger)showTime position:(NSString *)position) {
    NSLog(@"__canshu position = %@ showTime = %ld",position,showTime);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    [showView setUserInteractionEnabled:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [showView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];
        showView.layer.cornerRadius = 5.0f;
        showView.layer.masksToBounds = YES;
        [window addSubview:showView];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = message;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = 1;
        
        label.numberOfLines = 0;
        label.font = [UIFont boldSystemFontOfSize:TOAST_FONT_SIZE];
        CGRect realRect = [message boundingRectWithSize:CGSizeMake(TOAST_MAX_WIDTH, TOAST_MAX_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font}  context:nil];
        CGSize labelSize = realRect.size;
        labelSize.height = labelSize.height < TOAST_MIN_HEIGHT ? TOAST_MIN_HEIGHT : labelSize.height;
        labelSize.width = labelSize.width < TOAST_MIN_WIDTH ? TOAST_MIN_WIDTH : labelSize.width;
        label.frame = CGRectMake(10, 5, labelSize.width, labelSize.height);
        [showView addSubview:label];
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize size = rect.size;
        CGFloat width = size.width;
        CGFloat height = size.height;
        CGFloat positionPoint = 0.5;
        if (position) {
            if ([position isEqualToString:@"top"]) {
                positionPoint = 0.2;
            }else if ([position isEqualToString:@"center"]){
                positionPoint = 0.5;
            }else if ([position isEqualToString:@"bottom"]){
                positionPoint = 0.8;
            }
        }
        NSInteger realShowTime = showTime;
        if (realShowTime < 1) {
            realShowTime = 1;
        }else if (realShowTime > 5){
            realShowTime = 5;
        }
        showView.frame = CGRectMake((width - labelSize.width - 20) / 2, height * positionPoint, labelSize.width + 20, labelSize.height + 10);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(realShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                showView.alpha = 0;
            } completion:^(BOOL finished){
                [showView removeFromSuperview];
            }];
        });
    });
}

RCT_EXPORT_METHOD(messageLi:(NSString *)message) {
    NSLog(@"原生调用js--------%@",message);
    //发通知
    [self.bridge.eventDispatcher sendAppEventWithName:@"TestEventName" body:@{@"name": @"by lizhongfei"}];
}

@end
