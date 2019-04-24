//
//  MiSafeApp.h
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>

#define key_errorName        @"errorName"
#define key_errorReason      @"errorReason"
#define key_errorPlace       @"errorPlace"
#define key_defaultToDo      @"defaultToDo"
#define key_callStackSymbols @"callStackSymbols"
#define key_exception        @"exception"

#define AvoidCrashNotification @"AvoidCrashNotification"
#define AvoidCrashIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)


//user can ignore below define
#define AvoidCrashDefaultReturnNil      @"MiSafeApp default is to return nil to avoid crash."
#define AvoidCrashInitArrayRemoveNil    @"MiSafeApp default is to remove nil obj when instance array."
#define AvoidCrashInitDictRemoveNil    @"MiSafeApp default is to remove nil obj when instance dict."
#define AvoidCrashDefaultIgnore         @"MiSafeApp default is to ignore this operation to avoid crash."

#define AvoidCrashSeparator         @"================================================================"
#define AvoidCrashSeparatorWithFlag @"========================AvoidCrash Log=========================="


typedef enum MiSafeAvoidCrashType
{
    MiSafeAvoidCrashType_ReturnNil = 0,
    MiSafeAvoidCrashType_InitArrayRemoveNil,
    MiSafeAvoidCrashType_InitDictRemoveNil,
    MiSafeAvoidCrashType_Ignore
}MiSafeAvoidCrashType;


NS_ASSUME_NONNULL_BEGIN

@interface MiSafeApp : NSObject


+ (void)showCrashInfoWithException:(NSException *)exception avoidCrashType:(MiSafeAvoidCrashType)acType;

@end

NS_ASSUME_NONNULL_END
