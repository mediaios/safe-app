//
//  NSArray+MiSafe.m
//  MISafeApp
//
//  Created by mediaios on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSArray+MiSafe.h"
#import <objc/runtime.h>
#import "NSObject+MiSafe.h"

@implementation NSArray (MiSafe)

+ (void)load
{
    static dispatch_once_t miOnceToken;
    dispatch_once(&miOnceToken, ^{
        
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSPlaceholderArray") swizzSel:@selector(initWithObjects:count:) toSwizzledSel:@selector(miInitWithObjects:count:)];
        
        /********** 构造数组 **********/
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayI")
                                 swizzSel:@selector(objectAtIndexedSubscript:)
                            toSwizzledSel:@selector(miArrObjectAtIndexSubscript:)];
        
        
        
        /********** 取元素 **********/
        // [array objectAtIndex:1000] 方式发生的crash
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayI") swizzSel:@selector(objectAtIndex:) toSwizzledSel:@selector(miArrObjectAtIndex:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM") swizzSel:@selector(objectAtIndex:) toSwizzledSel:@selector(miMutaArrObjectAtIndex:)];
        
        // array[10000] 方式发生的crash
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayI")
                                 swizzSel:@selector(objectAtIndexedSubscript:)
                            toSwizzledSel:@selector(miArrObjectAtIndexSubscript:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM")
                                 swizzSel:@selector(objectAtIndexedSubscript:)
                            toSwizzledSel:@selector(miMutaArrObjectAtIndexSubscript:)];
        
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM") swizzSel:@selector(insertObject:atIndex:) toSwizzledSel:@selector(miMutaInsertObject:atIndex:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM") swizzSel:@selector(integerValue) toSwizzledSel:@selector(miIntegerValue)];
    });
}

#pragma mark - 构造数组
- (id)miInitWithObjects:(const id _Nonnull __unsafe_unretained *)objects
                  count:(NSUInteger)cnt
{
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        return [self miInitWithObjects:newObjects count:index];
    }
    return [self miInitWithObjects:objects count:cnt];
}

#pragma mark - 从数组中取元素
- (id)miEmptyObjAtIndex:(NSUInteger)index
{
    return nil;
}

- (id)miArrObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self miArrObjectAtIndex:index];
}

- (id)miMutaArrObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self miMutaArrObjectAtIndex:index];
}

- (id)miArrObjectAtIndexSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self miArrObjectAtIndex:index];
}

- (id)miMutaArrObjectAtIndexSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self miMutaArrObjectAtIndex:index];
}

- (void)miMutaInsertObject:(id)object atIndex:(NSUInteger)index
{
    if (object) {
        return [self miMutaInsertObject:object atIndex:index];
    }
}

- (NSInteger)miIntegerValue
{
    return 0;
}


@end
