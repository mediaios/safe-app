//
//  MiSafeApp.h
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiSafeModel.h"
#import "MiSafeAppHelper.h"

@class MiSafeApp;
@protocol MiSafeAppDelegate <NSObject>
- (void)miSafeApp:(MiSafeApp *)msApp crashInfo:(MiSafeCrashInfo *)msCrashInfo;
@optional


@end


NS_ASSUME_NONNULL_BEGIN

@interface MiSafeApp : NSObject

@property (nonatomic,weak) id<MiSafeAppDelegate> delegate;

+ (instancetype)shareInstance;

/**
 @brief 设置SDK的日志级别

 @discussion SDK默认不打印日志
 - MiSafeLogLevel_None: 不打印日志(建议release版本选择该设置)
 - MiSafeLogLevel_Display: 打印日志(建议debug版本选择该设置).
 
 @param logLevel `MiSafeLogLevel`类型。默认不打印任何日志。
 */
+ (void)setLogLevel:(MiSafeLogLevel)logLevel;

/**
 @brief 开启防止crash

 @discussion
 通过该方法，可以对`MiSafeApp`支持的崩溃类型进行选择性开启。你可以只开启防止`NSString`类型的崩溃；也可以同时支持KVO崩溃；当然还可以开启SDK所能支持所有崩溃类型。
 具体设置方法如下：
 eg: [MiSafeApp openAvoidCrashWithType:MiSafeCrashType_NSString];  // 仅仅开启了防止NSString类型的crash（包括NSString的子类）
 eg: [MiSafeApp openAvoidCrashWithType:MiSafeCrashType_All];   // 开启防止`MiSafeApp`SDK支持的所有类型崩溃
 
 @param cType `MiSafeCrashType`类型
 */
+ (void)openAvoidCrashWithType:(MiSafeCrashType)cType;


/**
 @brief 显示崩溃信息(内部使用)

 @param exception 崩溃信息
 @param cType 崩溃类型
 @param cDes 框架避免崩溃默认的操作
 */
+ (void)showCrashInfoWithException:(NSException *)exception
                         crashType:(MiSafeCrashType)cType
                          crashDes:(NSString *)cDes;



@end

NS_ASSUME_NONNULL_END
