//
//  NSUserDefaults+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/28.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSUserDefaults+MiSafe.h"
#import "NSObject+MiSafe.h"
#import "MiSafeApp.h"

@implementation NSUserDefaults (MiSafe)

+ (void)miOpenUserDefaultsMiSafe
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"NSUserDefaults");
        [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(setObject:forKey:)
                        toSwizzledSel:@selector(miSetObject:forKey:)];
        [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(objectForKey:)
                        toSwizzledSel:@selector(miObjectForKey:)];
        [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(integerForKey:)
                        toSwizzledSel:@selector(miIntegerForKey:)];
        [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(boolForKey:)
                        toSwizzledSel:@selector(miBoolForKey:)];
        
        
    });
}

- (void)miSetObject:(id)value forKey:(NSString *)defaultName
{

    if (defaultName) {
        [self miSetObject:value forKey:defaultName];
        return;
    }
    NSException *exception = [NSException exceptionWithName:@"MINSUserDefaultsException" reason:@"[setObject:forKey:], key is nil" userInfo:@{@"errorInfo":@"setObject:forKey error"}];
    [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSUserDefaults crashDes:@"[setObject:forKey:], key is nil"];
}

- (nullable id)miObjectForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self miObjectForKey:defaultName];
    }
    NSException *exception = [NSException exceptionWithName:@"MINSUserDefaultsException" reason:@"[objectForKey:], key is nil" userInfo:@{@"errorInfo":@"objectForKey: error"}];
    [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSUserDefaults crashDes:@"[objectForKey:], key is nil,return nil"];
    return nil;
    
}

- (NSInteger)miIntegerForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self miIntegerForKey:defaultName];
    }
    NSInteger obj=0;
    NSException *exception = [NSException exceptionWithName:@"MINSUserDefaultsException" reason:@"[integerForKey:], key is nil" userInfo:@{@"errorInfo":@"integerForKey: error"}];
    [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSUserDefaults crashDes:@"[integerForKey:], key is nil,return 0"];
    return obj;
}

- (BOOL)miBoolForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self miBoolForKey:defaultName];
    }
    NSException *exception = [NSException exceptionWithName:@"MINSUserDefaultsException" reason:@"[boolForKey:], key is nil" userInfo:@{@"errorInfo":@"[miBoolForKey:] error"}];
    [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSUserDefaults crashDes:@"[boolForKey:], key is nil,return NO"];
    return NO;
    
}

@end
