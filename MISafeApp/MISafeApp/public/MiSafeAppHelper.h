//
//  MiSafeAppHelper.h
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 iosmedia. All rights reserved.
//

#ifndef MiSafeAppHelper_h
#define MiSafeAppHelper_h

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



#define MiCrashSeparatorBegin        @"===================================MiSafeApp Detected A Crash======================================="
#define MiCrashSeparatorEnd          @"================================================End================================================="

#endif /* MiSafeAppHelper_h */
