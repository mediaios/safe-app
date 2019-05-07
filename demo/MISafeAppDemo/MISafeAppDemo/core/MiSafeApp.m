//
//  MiSafeApp.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "MiSafeApp.h"
#import "MiSafeModel.h"
#import "NSString+MiSafe.h"
#import "NSAttributedString+MiSafe.h"
#import "NSMutableString+MiSafe.h"
#import "NSArray+MiSafe.h"
#import "NSDictionary+MiSafe.h"
#import "NSObject+MiSafeKVO.h"
#import "NSObject+MiSafeKVC.h"
#import "NSUserDefaults+MiSafe.h"
#import "NSCache+MiSafe.h"
#import "NSSet+MiSafe.h"
#import "NSOrderedSet+MiSafe.h"
#import "NSData+MiSafe.h"
#import "NSNotificationCenter+MiSafe.h"
#import "NSTimer+MiSafe.h"


@implementation MiSafeApp

+ (void)openAvoidCrashWithType:(MiSafeCrashType)cType
{
    switch (cType) {
        case MiSafeCrashType_NSString:
        {
            [NSString miOpenNSStringMiSafe];
            [NSMutableString miOpenNSMutableStringMiSafe];
            [NSAttributedString miOpenNSAttributedStringMiSafe];
        }
            break;
        case MiSafeCrashType_NSArray:
            [NSArray miOpenNSArrayMiSafe];
            break;
        case MiSafeCrashType_NSDictionary:
            [NSDictionary miOpenNSDictionaryMiSafe];
            break;
        case MiSafeCrashType_NSSet:
            [NSSet miOpenNSSetMiSafe];
            break;
        case MiSafeCrashType_NSOrderSet:
            [NSOrderedSet miOpenNSOrderedSetMiSafe];
            break;
        case MiSafeCrashType_NSData:
            [NSData miOpenNSDataMiSafe];
            break;
        case MiSafeCrashType_NSCache:
            [NSCache miOpenNSCacheMiSafe];
            break;
        case MiSafeCrashType_NSNotification:
            [NSNotificationCenter miOpenNotificationMiSafe];
            break;
        case MiSafeCrashType_KVO:
            [NSObject miOpenKVOMiSafe];
            break;
        case MiSafeCrashType_KVC:
            [NSObject miOpenKVCMiSafe];
            break;
        case MiSafeCrashType_NSTimer:
            [NSTimer miOpenNSTimerMiSafe];
            break;
        case MiSafeCrashType_NSUserDefaults:
            [NSUserDefaults miOpenUserDefaultsMiSafe];
            break;
        case MiSafeCrashType_UnRecognizedSel:
            [NSObject miOpenUnrecognizedSelMiSafe];
            break;
        case MiSafeCrashType_All:
        {
            [NSString miOpenNSStringMiSafe];
            [NSMutableString miOpenNSMutableStringMiSafe];
            [NSAttributedString miOpenNSAttributedStringMiSafe];
            [NSArray miOpenNSArrayMiSafe];
            [NSDictionary miOpenNSDictionaryMiSafe];
            [NSSet miOpenNSSetMiSafe];
            [NSOrderedSet miOpenNSOrderedSetMiSafe];
            [NSData miOpenNSDataMiSafe];
            [NSCache miOpenNSCacheMiSafe];
            [NSNotificationCenter miOpenNotificationMiSafe];
            [NSObject miOpenKVOMiSafe];
            [NSObject miOpenKVCMiSafe];
            [NSTimer miOpenNSTimerMiSafe];
            [NSUserDefaults miOpenUserDefaultsMiSafe];
            [NSObject miOpenUnrecognizedSelMiSafe];
        }
            break;
        
        default:
            break;
    }
}


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

+ (void)showCrashInfoWithException:(NSException *)exception
                         crashType:(MiSafeCrashType)cType
                          crashDes:(NSString *)cDes
{
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    NSString *mainCallStackSymbolMsg = [MiSafeApp getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"The crash method failed to locate. Please check the function call stack to troubleshoot the cause of the error.";
    }
    NSString *crashDes = nil;
    switch (cType) {
        case MiSafeCrashType_NSString:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSString: %@}",cDes];
            break;
        case MiSafeCrashType_NSArray:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSArray: %@}",cDes];
            break;
        case MiSafeCrashType_NSDictionary:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSDictionary: %@}",cDes];
            break;
        case MiSafeCrashType_NSSet:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSSet: %@}",cDes];
            break;
        case MiSafeCrashType_NSOrderSet:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSOrderSet: %@}",cDes];
            break;
        case MiSafeCrashType_NSData:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSData: %@}",cDes];
            break;
        case MiSafeCrashType_NSCache:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSCache: %@}",cDes];
            break;
        case MiSafeCrashType_NSNotification:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSNotification: %@}",cDes];
            break;
        case MiSafeCrashType_KVO:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_KVO: %@}",cDes];
            break;
        case MiSafeCrashType_KVC:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_KVC: %@}",cDes];
            break;
        case MiSafeCrashType_NSTimer:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSTimer: %@}",cDes];
            break;
        case MiSafeCrashType_NSUserDefaults:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_NSUserDefaults: %@}",cDes];
            break;
        case MiSafeCrashType_UnRecognizedSel:
            crashDes = [NSString stringWithFormat:@"{MiSafeCrashType_UnRecognizedSel: %@}",cDes];
            break;
            
        default:
            break;
    }
    MiSafeCrashInfo *crashInfo = [MiSafeCrashInfo instanceWithName:exception.name reason:exception.reason location:mainCallStackSymbolMsg avoidCrashDes:crashDes callSymbolsStack:callStackSymbolsArr];
    NSLog(@"qizhang---debug-----%@",crashInfo);
}

@end
