//
//  NSObject+MiSafe.m
//  MISafeApp
//
//  Created by mediaios on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSObject+MiSafe.h"
#import <objc/runtime.h>
#import "MiSafeApp.h"

@implementation NSObject (MiSafe)

+ (void)miSwizzleInstanceMethod:(Class)class
                       swizzSel:(SEL)originSel
                  toSwizzledSel:(SEL)swizzledSel
{
    Method originMethod   =  class_getInstanceMethod(class, originSel);
    Method swizzledMethod =  class_getInstanceMethod(class, swizzledSel);
    BOOL didAddMethod = class_addMethod(class,
                                        originSel,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSel,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

+ (void)miSwizzleClassMethodWithClass:(Class)class
                             swizzSel:(SEL)originSel
                        toSwizzledSel:(SEL)swizzledSel
{
    Method originMethod  = class_getClassMethod(class, originSel);
    Method swizzledMethod = class_getClassMethod(class, swizzledSel);
    if (!originMethod || !swizzledMethod) {
        return;
    }
    IMP originImp = method_getImplementation(originMethod);
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    const char * originType = method_getTypeEncoding(originMethod);
    const char * swizzledTye = method_getTypeEncoding(swizzledMethod);
    
    // 添加方法到元类中
    Class metaClass = objc_getMetaClass(class_getName(class));
    class_replaceMethod(metaClass, swizzledSel, originImp, originType);
    class_replaceMethod(metaClass, originSel, swizzledImp, swizzledTye);
}

+ (void)miSwizzleNSObjectMethod
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

#pragma mark -防止KVC操作Crash
- (void)miKVCSetValue:(id)value forKey:(NSString *)key;
{
    @try {
        [self miKVCSetValue:value forKey:key];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miKVCSetValue:(id)value forKeyPath:(NSString *)keyPath
{
    @try {
        [self miKVCSetValue:value forKeyPath:keyPath];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miKVCSetValuesForKeysWithDictionary:(NSDictionary<NSString *, id> *)keyedValues
{
    @try {
        [self miKVCSetValuesForKeysWithDictionary:keyedValues];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miKVCSetValue:(id)value forUndefinedKey:(NSString *)key
{
    @try {
        [self miKVCSetValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}



@end
