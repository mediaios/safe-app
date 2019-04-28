//
//  MiSafeApp.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "MiSafeApp.h"
#import "MiSafeModel.h"
#import "NSObject+MiSafeKVO.h"
#import "NSObject+MiSafeKVC.h"


@implementation MiSafeApp

/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    return mainCallStackSymbolMsg;
}

+ (void)showCrashInfoWithException:(NSException *)exception avoidCrashType:(MiSafeAvoidCrashType)acType
{
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    NSString *mainCallStackSymbolMsg = [MiSafeApp getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"The crash method failed to locate. Please check the function call stack to troubleshoot the cause of the error.";
    }
    NSString *avoidCrashDes = AvoidCrashDefaultReturnNil;
    switch (acType) {
        case MiSafeAvoidCrashType_ReturnNil:
            avoidCrashDes = AvoidCrashDefaultReturnNil;
            break;
        case MiSafeAvoidCrashType_InitArrayRemoveNil:
            avoidCrashDes = AvoidCrashInitArrayRemoveNil;
            break;
        case MiSafeAvoidCrashType_InitDictRemoveNil:
            avoidCrashDes = AvoidCrashInitDictRemoveNil;
            break;
        case MiSafeAvoidCrashType_Ignore:
            avoidCrashDes = AvoidCrashDefaultIgnore;
            break;
            
        default:
            break;
    }
    
    MiSafeCrashInfo *crashInfo = [MiSafeCrashInfo instanceWithName:exception.name reason:exception.reason location:mainCallStackSymbolMsg avoidCrashDes:avoidCrashDes callSymbolsStack:callStackSymbolsArr];
    NSLog(@"qizhang---debug-----%@",crashInfo);
}

+ (void)openKVCSafe
{
    [NSObject miOpenKVCMiSafe];
    [NSObject miOpenKVOMiSafe];
}

@end
