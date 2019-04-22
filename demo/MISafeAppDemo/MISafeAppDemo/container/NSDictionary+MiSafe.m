//
//  NSDictionary+MiSafe.m
//  MISafeAppDemo
//
//  Created by ethan on 2019/4/22.
//  Copyright © 2019 ucloud. All rights reserved.
//

#import "NSDictionary+MiSafe.h"
#import "NSObject+MiSafe.h"
#import <objc/runtime.h>

@implementation NSDictionary (MiSafe)

+ (void)load
{
    static dispatch_once_t miOnceToken;
    dispatch_once(&miOnceToken, ^{
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSPlaceholderDictionary")
                                 swizzSel:@selector(initWithObjects:forKeys:count:)
                            toSwizzledSel:@selector(miInitWithObjects:forKeys:count:)];
        
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSPlaceholderDictionary")
                                 swizzSel:@selector(initWithObjects:forKeys:)
                            toSwizzledSel:@selector(miInitWithObjects:forKeys:)];
        
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSDictionaryM")
                                 swizzSel:@selector(setObject:forKey:)
                            toSwizzledSel:@selector(miSetObject:forKey:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSDictionaryM")
                                 swizzSel:@selector(setObject:forKeyedSubscript:)
                            toSwizzledSel:@selector(miSetObject:forKeyedSubscript:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSDictionaryM")
                                 swizzSel:@selector(removeObjectForKey:)
                            toSwizzledSel:@selector(miRemoveObjectForKey:)];
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
    if (!objects || !keys) {
        return nil;
    }
    
    NSUInteger count = objects.count >= keys.count ? keys.count : objects.count;
    NSMutableArray *new_objs = [NSMutableArray array];
    NSMutableArray *new_keys = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        if (objects[i] && keys[i]) {
            [new_objs addObject:objects[i]];
            [new_keys addObject:keys[i]];
        }
    }
    return [self miInitWithObjects:new_objs forKeys:new_keys];
}

- (instancetype)miInitWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
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
    return [self miInitWithObjects:tempObjects forKeys:tempKeys count:validCount];
}

- (void)miSetObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (!anObject || !aKey) {
        return;
    }
    [self miSetObject:anObject forKey:aKey];
}

- (void)miSetObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    if (!key) {
        return;
    }
    [self miSetObject:obj forKeyedSubscript:key];
}

- (void)miRemoveObjectForKey:(id)key
{
    if (!key) {
        return;
    }
    [self miRemoveObjectForKey:key];
}

- (void)miSetCFDictObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject || !aKey) {
        return;
    }
    [self miSetCFDictObject:anObject forKey:aKey];
}

- (void)miRemoveCFDictObjectForKey:(id)key
{
    if (!key) {
        return;
    }
    [self miRemoveCFDictObjectForKey:key];
}


@end
