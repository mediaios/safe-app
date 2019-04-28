//
//  NSCache+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail on 2019/4/28.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSCache+MiSafe.h"
#import "NSObject+MiSafe.h"
#import "MiSafeApp.h"

@implementation NSCache (MiSafe)

+ (void)miOpenNSCacheMiSafe
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class=NSClassFromString(@"NSCache");
        [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(setObject:forKey:)
                        toSwizzledSel:@selector(miCacheSetObject:forKey:)];
        [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(setObject:forKey:cost:)
                        toSwizzledSel:@selector(miCacheSetObject:forKey:cost:)];
    });
}


- (void)miCacheSetObject:(id)obj forKey:(id)key
{
    if(key&&obj){
        [self miCacheSetObject:obj forKey:key];
        return;
    }
    
    NSException *exception = [NSException exceptionWithName:@"MINSCacheException" reason:@"[setObject:forKey:], key is nil" userInfo:@{@"errorInfo":@"[setObject:forKey:] error"}];
    [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
}

- (void)miCacheSetObject:(id)obj forKey:(id)key cost:(NSUInteger)g
{
    if (key && obj) {
        [self miCacheSetObject:obj forKey:key cost:g];
        return;
    }
    NSException *exception = [NSException exceptionWithName:@"MINSCacheException" reason:@"[setObject:forKey:cost:], key is nil" userInfo:@{@"errorInfo":@"[setObject:forKey:cost:] error"}];
    [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    
}
@end
