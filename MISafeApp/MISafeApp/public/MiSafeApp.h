//
//  MiSafeApp.h
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @brief 设置SDK的日志级别

 @discussion 建议当应用出于debug阶段时，设置打印日志；当应用要发布时，设置不打印日志。
 
 - MiSafeLogLevel_None: 不打印日志(建议release版本选择该设置)
 - MiSafeLogLevel_Display: 打印日志(建议debug版本选择该设置)
 */
typedef NS_ENUM(NSUInteger,MiSafeLogLevel)
{
    MiSafeLogLevel_None,
    MiSafeLogLevel_Display
};

/**
 @brief 这是一个枚举类型，定义崩溃类型

 - MiSafeCrashType_NSString: `NSString`相关的崩溃，包括其子类(NSMutableString等)
 - MiSafeCrashType_NSArray: `NSArray`相关的崩溃，包括其子类
 - MiSafeCrashType_NSDictionary: `NSDictionary`相关的崩溃，包括其子类
 - MiSafeCrashType_NSSet: `NSSet`相关的崩溃，包括其子类
 - MiSafeCrashType_NSOrderSet: `NSOrderSet`相关的崩溃，包括其子类
 - MiSafeCrashType_NSData: `NSData`相关的崩溃，包括其子类
 - MiSafeCrashType_NSCache: `NSCache`相关的崩溃，包括其子类
 - MiSafeCrashType_NSNotification: `NSNotification`相关的崩溃，包括其子类
 - MiSafeCrashType_KVO: `KVO`相关的崩溃，包括其子类
 - MiSafeCrashType_KVC: `KVC`相关的崩溃，包括其子类
 - MiSafeCrashType_NSTimer: `NSTimer`相关的崩溃，包括其子类
 - MiSafeCrashType_NSUserDefaults: `NSUserDefaults`相关的崩溃，包括其子类
 - MiSafeCrashType_UnRecognizedSel: `UnRecognizedSel`相关的崩溃，包括其子类
 - MiSafeCrashType_All: 包含以上的所有崩溃(在设置开关中，如果选择此参数，则框架会拦截以上所有类型的崩溃)
 */
typedef NS_ENUM(NSUInteger,MiSafeCrashType)
{
    MiSafeCrashType_NSString,
    MiSafeCrashType_NSArray,
    MiSafeCrashType_NSDictionary,
    MiSafeCrashType_NSSet,
    MiSafeCrashType_NSOrderSet,
    MiSafeCrashType_NSData,
    MiSafeCrashType_NSCache,
    MiSafeCrashType_NSNotification,
    MiSafeCrashType_KVO,
    MiSafeCrashType_KVC,
    MiSafeCrashType_NSTimer,
    MiSafeCrashType_NSUserDefaults,
    MiSafeCrashType_UnRecognizedSel,
    MiSafeCrashType_All
};


NS_ASSUME_NONNULL_BEGIN

@interface MiSafeApp : NSObject


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
