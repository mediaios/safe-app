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
        
         /*************** 防止KVO操作crash  ****************/
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(addObserver:forKeyPath:options:context:)
                        toSwizzledSel:@selector(miKVOAddObserver:forKeyPath:options:context:)];
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(removeObserver:forKeyPath:)
                        toSwizzledSel:@selector(miKVORemoveObserver:forKeyPath:)];
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(observeValueForKeyPath:ofObject:change:context:)
                        toSwizzledSel:@selector(miKVOObserveValueForKeyPath:ofObject:change:context:)];
    });
    
}

#pragma mark - 防止KVC操作Crash
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

#pragma mark - 防止KVO操作crash
- (void)miKVOAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    @try {
        if (observer && keyPath && ![self kvoOperationEffective:keyPath observer:observer]) {
            [self miKVOAddObserver:observer forKeyPath:keyPath options:options context:context];
        }else{
            NSException *exception = [NSException exceptionWithName:@"KVOException" reason:@"param error" userInfo:@{@"errorInfo":@"add KVO observer error"}];
            [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
            NSLog(@"添加监听时，参数非法");
        }
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miKVORemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    @try {
        if (observer && keyPath && [self kvoOperationEffective:keyPath observer:observer]) {
            [self miKVORemoveObserver:observer forKeyPath:keyPath];
        }else{
            NSException *exception = [NSException exceptionWithName:@"KVOException" reason:@"param error" userInfo:@{@"errorInfo":@"remove KVO observer error"}];
            [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
            NSLog(@"移除监听时，参数非法");
        }
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miKVOObserveValueForKeyPath:( NSString *)keyPath ofObject:(id)object change:( NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    @try {
        [self miKVOObserveValueForKeyPath:keyPath ofObject:object change:change context:context];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (BOOL)kvoOperationEffective:(NSString *)key observer:(id)observer
{
    id info = self.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id Properties = [objc valueForKeyPath:@"_property"];
        id newObserver = [objc valueForKeyPath:@"_observer"];
        
        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
        if ([key isEqualToString:keyPath] && [newObserver isEqual:observer]) {
            return YES;
        }
    }
    return NO;
}



@end
