//
//  MiSafeModel.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "MiSafeModel.h"
#import "MiSafeAppHelper.h"

@implementation MiSafeCrashInfo

- (instancetype)initWithName:(NSString *)name
                      reason:(NSString *)reason
                    location:(NSString *)location
               avoidCrashDes:(NSString *)avoidCrashDes
            callSymbolsStack:(NSArray *)callSymbolsStack
{
    if (self = [super init]) {
        _name = name;
        _reason = reason;
        _location = location;
        _avoidCrashDes = avoidCrashDes;
        _callSymbolsStack = callSymbolsStack;
    }
    return self;
}


+ (instancetype)instanceWithName:(NSString *)name
                          reason:(NSString *)reason
                        location:(NSString *)location
                   avoidCrashDes:(NSString *)avoidCrashDes
                callSymbolsStack:(NSArray *)callSymbolsStack

{
    return [[self alloc] initWithName:name
                               reason:reason
                             location:location
                        avoidCrashDes:avoidCrashDes
                     callSymbolsStack:callSymbolsStack];
}

- (NSString *)description
{
    NSMutableString *crashInfo = [NSMutableString stringWithString:[NSString stringWithFormat:@"\n%@\n",MiCrashSeparatorBegin]];
    [crashInfo appendString:[NSString stringWithFormat:@"[Crash Name]:  %@ \n",self.name]];
    [crashInfo appendString:[NSString stringWithFormat:@"[Crash Reason]: %@ \n",self.reason]];
    [crashInfo appendString:[NSString stringWithFormat:@"[Crash Location]: %@ \n",self.location]];
    [crashInfo appendString:[NSString stringWithFormat:@"[Crash MiSafeAppAvoidCrashDes]: %@ \n",self.avoidCrashDes]];
    [crashInfo appendString:[NSString stringWithFormat:@"[Crash callSymbolsStack]: %@ \n",self.callSymbolsStack]];
    [crashInfo appendString:[NSString stringWithFormat:@"%@\n",MiCrashSeparatorEnd]];
    return crashInfo;
}

@end


@implementation MiSafeModel



@end
