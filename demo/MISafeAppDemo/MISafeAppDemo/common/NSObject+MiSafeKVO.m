//
//  NSObject+MiSafeKVO.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/28.
//  Copyright © 2019 iosmedia. All rights reserved.
//

#import "NSObject+MiSafeKVO.h"
#import "NSObject+MiSafe.h"
#import "MiSafeApp.h"


/**
 @brief 防止KVO崩溃
 
 @discussion 防止KVO崩溃的策略:  1.防止添加和删除observer不对称； 2.在对象销毁的时候，删除所有observer
 */
@implementation NSObject (MiSafeKVO)


+ (void)miOpenKVOMiSafe
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(addObserver:forKeyPath:options:context:)
                        toSwizzledSel:@selector(miKVOAddObserver:forKeyPath:options:context:)];
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(removeObserver:forKeyPath:)
                        toSwizzledSel:@selector(miKVORemoveObserver:forKeyPath:)];
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(removeObserver:forKeyPath:context:)
                        toSwizzledSel:@selector(miKVORemoveObserver:forKeyPath:context:)];
        [self miSwizzleInstanceMethod:[self class]
                             swizzSel:@selector(observeValueForKeyPath:ofObject:change:context:)
                        toSwizzledSel:@selector(miKVOObserveValueForKeyPath:ofObject:change:context:)];
    });
}

#pragma mark - 防止KVO操作crash
- (void)miKVOAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    @try {
        if (observer && keyPath && ![self kvoOperationEffective:keyPath observer:observer]) {
            [self miKVOAddObserver:observer forKeyPath:keyPath options:options context:context];
        }else{
            NSException *exception = [NSException exceptionWithName:@"MIKVOException" reason:@"param error" userInfo:@{@"errorInfo":@"add KVO observer error"}];
            [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[addObserver:forKeyPath:options:context:] crash , ignore this method operation"];
        }
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[addObserver:forKeyPath:options:context:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miKVORemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    @try {
        if (observer && keyPath && [self kvoOperationEffective:keyPath observer:observer]) {
            [self miKVORemoveObserver:observer forKeyPath:keyPath];
        }else{
            NSException *exception = [NSException exceptionWithName:@"KVOException" reason:@"param error" userInfo:@{@"errorInfo":@"remove KVO observer error"}];
            [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[removeObserver:forKeyPath:] crash , ignore this method operation"];
        }
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[removeObserver:forKeyPath:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miKVORemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context
{
    @try {
        if (observer && keyPath && [self kvoOperationEffective:keyPath observer:observer] && context) {
            [self miKVORemoveObserver:observer forKeyPath:keyPath context:context];
        }else{
            NSException *exception = [NSException exceptionWithName:@"KVOException" reason:@"param error" userInfo:@{@"errorInfo":@"remove KVO observer error"}];
            [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[removeObserver:forKeyPath:context:] crash , ignore this method operation"];
        }
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[removeObserver:forKeyPath:context:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miKVOObserveValueForKeyPath:( NSString *)keyPath ofObject:(id)object change:( NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    @try {
        [self miKVOObserveValueForKeyPath:keyPath ofObject:object change:change context:context];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_KVO crashDes:@"(NSObject)[observeValueForKeyPath:ofObject:change:context:] crash , ignore this method operation"];
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


