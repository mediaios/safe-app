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
#import "MiSafeApp.h"

@implementation NSArray (MiSafe)

+ (void)load
{
    static dispatch_once_t miOnceToken;
    dispatch_once(&miOnceToken, ^{
        /********** 构造数组 **********/
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSPlaceholderArray") swizzSel:@selector(initWithObjects:count:) toSwizzledSel:@selector(miInitWithObjects:count:)];
        
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
        
        /********** 插入元素 **********/
        // 插入元素： 元素为nil; index非法
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM")
                                 swizzSel:@selector(insertObject:atIndex:)
                            toSwizzledSel:@selector(miMutaInsertObject:atIndex:)];
        
        /********** 删除元素 **********/
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM")
                                 swizzSel:@selector(removeObjectsInRange:)
                            toSwizzledSel:@selector(miRemoveObjectsInRange:)];
        
        /********** 替换数组中元素 **********/
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM")
                                 swizzSel:@selector(replaceObjectAtIndex:withObject:)
                            toSwizzledSel:@selector(miReplaceObjectAtIndex:withObject:)];
        
        
        /********** 交换数组中元素 **********/
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM")
                                 swizzSel:@selector(exchangeObjectAtIndex:withObjectAtIndex:)
                            toSwizzledSel:@selector(miExchangeObjectAtIndex:withObjectAtIndex:)];
        
        /********** 删除元素 **********/
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSMutableArray")
                                 swizzSel:@selector(removeObject:inRange:)
                            toSwizzledSel:@selector(miRemoveObject:inRange:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSMutableArray")
                                 swizzSel:@selector(removeObjectIdenticalTo:inRange:)
                            toSwizzledSel:@selector(miRemoveObjectIdenticalTo:inRange:)];
        
        /********** 替换元素 **********/
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSMutableArray")
                                 swizzSel:@selector(replaceObjectsInRange:withObjectsFromArray:range:)
                            toSwizzledSel:@selector(miReplaceObjectsInRange:withObjectsFromArray:range:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSMutableArray")
                                 swizzSel:@selector(replaceObjectsInRange:withObjectsFromArray:)
                            toSwizzledSel:@selector(miReplaceObjectsInRange:withObjectsFromArray:)];
        
        
        [NSObject miSwizzleInstanceMethod:objc_getClass("__NSArrayM") swizzSel:@selector(integerValue) toSwizzledSel:@selector(miIntegerValue)];
    });
}

#pragma mark - 构造数组
- (id)miInitWithObjects:(const id _Nonnull __unsafe_unretained *)objects
                  count:(NSUInteger)cnt
{
    id array = nil;
    @try {
        array = [self miInitWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_InitArrayRemoveNil];
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
            array = [self miInitWithObjects:newObjects count:index];
        }
    } @finally {
        return array;
    }
}

#pragma mark - 从数组中取元素
- (id)miEmptyObjAtIndex:(NSUInteger)index
{
    
    id ele = nil;
    @try {
        ele = [self miEmptyObjAtIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    } @finally {
        return ele;
    }
}

- (id)miArrObjectAtIndex:(NSUInteger)index
{
    id ele = nil;
    @try {
        ele = [self miArrObjectAtIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    } @finally {
        return ele;
    }
}

- (id)miMutaArrObjectAtIndex:(NSUInteger)index
{
    
    id ele = nil;
    @try {
        ele = [self miMutaArrObjectAtIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    } @finally {
        return ele;
    }
}

- (id)miArrObjectAtIndexSubscript:(NSUInteger)index
{
    id ele = nil;
    @try {
        ele = [self miArrObjectAtIndexSubscript:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    } @finally {
        return ele;
    }
}

- (id)miMutaArrObjectAtIndexSubscript:(NSUInteger)index
{
    
    id ele = nil;
    @try {
        ele = [self miMutaArrObjectAtIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    } @finally {
        return ele;
    }
}

#pragma mark - 插入元素
- (void)miMutaInsertObject:(id)object atIndex:(NSUInteger)index
{
    @try {
        [self miMutaInsertObject:object atIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
        return;
    } @finally {}
    
}

#pragma mark - 删除元素
- (void)miRemoveObjectsInRange:(NSRange)range
{
    @try {
        [self miRemoveObjectsInRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miRemoveObject:(id)anObject inRange:(NSRange)range
{
    @try {
         [self miRemoveObject:anObject inRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miRemoveObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    @try {
        [self miRemoveObjectIdenticalTo:anObject inRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

#pragma mark - 替换元素
- (void)miReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @try {
        [self miReplaceObjectAtIndex:index withObject:anObject];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(id)otherArray range:(NSRange)otherRange
{
    @try {
        [self miReplaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(id)otherArray
{

    @try {
        [self miReplaceObjectsInRange:range withObjectsFromArray:otherArray];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

#pragma mark - 交换元素
- (void)miExchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    @try {
        [self miExchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (NSInteger)miIntegerValue
{
    NSInteger iV = 0;
    @try {
       iV = [self miIntegerValue];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {
        return iV;
    }
}


@end
