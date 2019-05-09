//
//  ViewController.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "MiSafeApp.h"


@interface ViewController ()<MiSafeAppDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MiSafeApp shareInstance].delegate =  self;
}

#pragma mark -MiSafeAppDelegate
- (void)miSafeApp:(MiSafeApp *)msApp crashInfo:(MiSafeCrashInfo *)msCrashInfo
{
    if (msCrashInfo) {
        NSLog(@"%@",msCrashInfo);
    }
}

@end
