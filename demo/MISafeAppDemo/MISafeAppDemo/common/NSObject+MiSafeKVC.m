//
//  NSObject+MiSafeKVC.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/28.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSObject+MiSafeKVC.h"
#import "NSObject+MiSafe.h"
#import "MiSafeApp.h"

@implementation NSObject (MiSafeKVC)

+ (void)miOpenKVCMiSafe
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*************** 防止KVC操作crash  ****************/
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(setValue:forKey:)
                        toSwizzledSel:@selector(miKVCSetValue:forKey:)];
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(setValue:forKeyPath:)
                        toSwizzledSel:@selector(miKVCSetValue:forKeyPath:)];
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(setValuesForKeysWithDictionary:)
                        toSwizzledSel:@selector(miKVCSetValuesForKeysWithDictionary:)];
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(setValue:forUndefinedKey:)
                        toSwizzledSel:@selector(miKVCSetValue:forUndefinedKey:)];
        
    });
   
}

- (void)miKVCSetValue:(id)value forKey:(NSString *)key;
{
    @try {
        [self miKVCSetValue:value forKey:key];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[setValue:forKey:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miKVCSetValue:(id)value forKeyPath:(NSString *)keyPath
{
    @try {
        [self miKVCSetValue:value forKeyPath:keyPath];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[setValue:forKeyPath:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miKVCSetValuesForKeysWithDictionary:(NSDictionary<NSString *, id> *)keyedValues
{
    @try {
        [self miKVCSetValuesForKeysWithDictionary:keyedValues];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[setValuesForKeysWithDictionary:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miKVCSetValue:(id)value forUndefinedKey:(NSString *)key
{
    @try {
        [self miKVCSetValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[setValue:forUndefinedKey:] crash , ignore this method operation"];
    } @finally {}
}

@end
