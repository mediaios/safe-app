//
//  MiSafeApp.h
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MiSafe.h"

#define key_errorName        @"errorName"
#define key_errorReason      @"errorReason"
#define key_errorPlace       @"errorPlace"
#define key_defaultToDo      @"defaultToDo"
#define key_callStackSymbols @"callStackSymbols"
#define key_exception        @"exception"

#define AvoidCrashNotification @"AvoidCrashNotification"
#define AvoidCrashIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

#define AvoidCrashSeparator         @"================================================================"
#define AvoidCrashSeparatorWithFlag @"========================AvoidCrash Log=========================="


typedef enum MiSafeCrashType
{
    MiSafeCrashType_NSString = 0,
    MiSafeCrashType_NSArray,
    MiSafeCrashType_NSDictionary,
    MiSafeCrashType_NSSet,
    MiSafeCrashType_NSData,
    MiSafeCrashType_NSCache,
    MiSafeCrashType_NSNotification,
    MiSafeCrashType_KVO,
    MiSafeCrashType_KVC,
    MiSafeCrashType_NSTimer,
    MiSafeCrashType_NSUserDefaults,
    MiSafeCrashType_UnRecognizedSel
}MiSafeCrashType;


NS_ASSUME_NONNULL_BEGIN

@interface MiSafeApp : NSObject


+ (void)showCrashInfoWithException:(NSException *)exception
                         crashType:(MiSafeCrashType)cType
                          crashDes:(NSString *)cDes;

+ (void)openKVCSafe;

@end

NS_ASSUME_NONNULL_END
