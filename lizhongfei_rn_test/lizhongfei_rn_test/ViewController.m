//
//  ViewController.m
//  lizhongfei_rn_test
//
//  Created by lizhongfei on 2/11/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

#import "ViewController.h"
#import <RCTRootView.h>

@interface ViewController ()

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
    
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                         moduleName:@"lizhongfei_rn_test"
                                                  initialProperties:nil
                                                      launchOptions:nil];
    rootView.frame=CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width, 200);
    [self.view addSubview:rootView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
