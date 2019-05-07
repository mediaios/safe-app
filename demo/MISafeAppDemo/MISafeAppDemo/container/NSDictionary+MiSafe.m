//
//  NSDictionary+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/22.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSDictionary+MiSafe.h"
#import "NSObject+MiSafe.h"
#import <objc/runtime.h>
#import "MiSafeApp.h"

@implementation NSDictionary (MiSafe)

+ (void)load
{
    static dispatch_once_t miOnceToken;
    dispatch_once(&miOnceToken, ^{
        /**************************************** 构造字典 ****************************************/
        // 使用[alloc]方法的初始化只需要hook `__NSPlaceholderDictionary`的init方法即可
        Class placeHolderDict = objc_getClass("__NSPlaceholderDictionary");
        [self miSwizzleInstanceMethod:placeHolderDict
                                 swizzSel:@selector(initWithObjects:forKeys:count:)
                            toSwizzledSel:@selector(miInitWithObjects:forKeys:count:)];
        [self miSwizzleInstanceMethod:placeHolderDict
                                 swizzSel:@selector(initWithObjects:forKeys:)
                            toSwizzledSel:@selector(miInitWithObjects:forKeys:)];
        // hook 使用类方法的初始化方式
        [NSObject miSwizzleClassMethodWithClass:object_getClass(@"NSDictionary")
                                       swizzSel:@selector(dictionaryWithObjects:forKeys:count:)
                                  toSwizzledSel:@selector(miDictionaryWithObjects:forKeys:count:)];
        
        
        /**************************************** 字典操作 ****************************************/
//        Class dict0Class = objc_getClass("__NSDictionary0");
        Class dictOneClass = objc_getClass("__NSSingleEntryDictionaryI");
//        Class dictClass = objc_getClass("__NSDictionaryI");
        [self miSwizzleInstanceMethod:dictOneClass
                             swizzSel:@selector(valueForUndefinedKey:) toSwizzledSel:@selector(miOneEleDictValueForUndefinedKey:)];
        
        
        Class mutaDictClass = objc_getClass("__NSDictionaryM");
        [self miSwizzleInstanceMethod:mutaDictClass
                                 swizzSel:@selector(setObject:forKey:)
                            toSwizzledSel:@selector(miSetObject:forKey:)];
        [self miSwizzleInstanceMethod:mutaDictClass
                                 swizzSel:@selector(setObject:forKeyedSubscript:)
                            toSwizzledSel:@selector(miSetObject:forKeyedSubscript:)];
        [self miSwizzleInstanceMethod:mutaDictClass
                                 swizzSel:@selector(removeObjectForKey:)
                            toSwizzledSel:@selector(miRemoveObjectForKey:)];
        
        // 对NSMutableDict做拷贝，拷贝之后字典添加元素会crash.   //待定
        Class frozenDictClass = objc_getClass("__NSFrozenDictionaryM");
        [self miSwizzleInstanceMethod:frozenDictClass
                             swizzSel:@selector(setObject:forKey:)
                        toSwizzledSel:@selector(miFrozenDictSetObject:forKey:)];
        [self miSwizzleInstanceMethod:frozenDictClass
                             swizzSel:@selector(setObject:forKeyedSubscript:)
                        toSwizzledSel:@selector(miSetFrozenDictSetObject:forKeyedSubscript:)];
        
        [self miSwizzleInstanceMethod:objc_getClass("__NSCFDictionary")
                             swizzSel:@selector(setObject:forKey:)
                        toSwizzledSel:@selector(miSetCFDictObject:forKey:)];
        [self miSwizzleInstanceMethod:objc_getClass("__NSCFDictionary")
                             swizzSel:@selector(removeObjectForKey:)
                        toSwizzledSel:@selector(miRemoveCFDictObjectForKey:)];
        
    });
}

- (instancetype)miInitWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys
{
    id dict = nil;
    @try {
        dict = [self miInitWithObjects:objects forKeys:keys];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSPlaceholderDictionary)[initWithObjects:forKeys:] crash , remove nil elements"];
        if (objects && keys) {
            NSUInteger count = objects.count >= keys.count ? keys.count : objects.count;
            NSMutableArray *new_objs = [NSMutableArray array];
            NSMutableArray *new_keys = [NSMutableArray array];
            for (int i = 0; i < count; i++) {
                if (objects[i] && keys[i]) {
                    [new_objs addObject:objects[i]];
                    [new_keys addObject:keys[i]];
                }
            }
            dict = [self miInitWithObjects:new_objs forKeys:new_keys];
        }
    } @finally {
        return dict;
    }
}

- (instancetype)miInitWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    id dict = nil;
    @try {
        dict = [self miInitWithObjects:objects forKeys:keys count:cnt];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSPlaceholderDictionary)[initWithObjects:forKeys:count:] crash , remove nil elements"];
        id tempObjects[cnt];
        id tempKeys[cnt];
        NSUInteger validCount = 0;
        for (NSUInteger i = 0; i < cnt; i++) {
            id key = keys[i];
            id obj = objects[i];
            if (!key || !obj) {
                continue;
            }
            if (!obj) {
                obj = [NSNull null];
            }
            tempKeys[validCount] = key;
            tempObjects[validCount] = obj;
            validCount++;
        }
        dict = [self miInitWithObjects:tempObjects forKeys:tempKeys count:validCount];
    } @finally {
        return dict;
    }
}

+ (instancetype)miDictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
{
    id instance = nil;
    @try {
        instance = [self miDictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSPlaceholderDictionary)[dictionaryWithObjects:forKeys:count:] crash , remove nil elements"];
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self miDictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

#pragma mark -字典操作
- (id)miOneEleDictValueForUndefinedKey:(NSString *)key;
{
    id instance = nil;
    @try {
        instance = [self miOneEleDictValueForUndefinedKey:key];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSSingleEntryDictionaryI)[valueForUndefinedKey:] crash , return nil"];
    } @finally {
        return instance;
    }
}

- (void)miSetObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    @try {
        [self miSetObject:anObject forKey:aKey];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSDictionaryM)[setObject:forKey:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miFrozenDictSetObject:(id)anObject forKey:(id <NSCopying>)aKey
{
//    @try {
////        [self miFrozenDictSetObject:anObject forKey:aKey];
//    } @catch (NSException *exception) {
//        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSFrozenDictionaryM)[setObject:forKey:] crash , ignore this method operation"];
//    } @finally {}
    
    NSException *exception = [NSException exceptionWithName:@"MINSDictionaryException" reason:@"[setObject:forKey:], a copy dict be set object" userInfo:@{@"errorInfo":@"setObject:forKey: a copy dict be set object"}];
    [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSFrozenDictionaryM)[setObject:forKey:] crash , ignore this method operation"];
}

- (void)miSetFrozenDictSetObject:(id)anObject forKeyedSubscript:(id <NSCopying>)aKey
{
//    @try {
////        [self miSetFrozenDictSetObject:anObject forKeyedSubscript:aKey];
//    } @catch (NSException *exception) {
//        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSFrozenDictionaryM)[setObject:forKeyedSubscript:] crash , ignore this method operation"];
//    } @finally {}
    
    NSException *exception = [NSException exceptionWithName:@"MINSDictionaryException" reason:@"[setObject:forKeyedSubscript:], a copy dict be set object" userInfo:@{@"errorInfo":@"setObject:forKey: a copy dict be set object"}];
    [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSFrozenDictionaryM)[setObject:forKeyedSubscript:] crash , ignore this method operation"];
}

- (void)miSetObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    @try {
        [self miSetObject:obj forKeyedSubscript:key];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSCFDictionary)[setObject:forKeyedSubscript:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miRemoveObjectForKey:(id)key
{
    @try {
        [self miRemoveObjectForKey:key];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSCFDictionary)[removeObjectForKey:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miSetCFDictObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    @try {
        [self miSetCFDictObject:anObject forKey:aKey];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSCFDictionary)[setObject:forKey:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miRemoveCFDictObjectForKey:(id)key
{
    @try {
        [self miRemoveCFDictObjectForKey:key];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSDictionary crashDes:@"(__NSCFDictionary)[removeObjectForKey:] crash , ignore this method operation"];
    } @finally {}
    
}


@end
