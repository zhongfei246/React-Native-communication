//
//  NativeToast.h
//  lizhongfei_rn_test
//
//  Created by lizhongfei on 3/11/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTBridgeModule.h"
#import "RCTLog.h"
#import "RCTBridge.h"

@interface NativeToast : NSObject<RCTBridgeModule>

@property RCTBridge* bridge;

@end
