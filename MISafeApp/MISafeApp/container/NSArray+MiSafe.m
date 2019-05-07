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
+ (void)miOpenNSArrayMiSafe
{
    static dispatch_once_t miOnceToken;
    dispatch_once(&miOnceToken, ^{
        /**************************************** 构造数组 ****************************************/
        // 按照 [alloc] 方式创建的数组(NSArray&NSMutableArray)，都需要去hook `__NSPlaceholderArray`
        [self miSwizzleInstanceMethod:objc_getClass("__NSPlaceholderArray") swizzSel:@selector(initWithObjects:count:) toSwizzledSel:@selector(miInitWithObjects:count:)];
        
        /**************************************** NSArray操作 ****************************************/
        /*
         NSArray的数组操作：
         '__NSArray0' : 一个空的NSArray
         '__NSSingleObjectArrayI' : 只有一个元素的NSArray
         `__NSArrayI` : 元素个数大于1的NSArray
         
         所以以上三个class的所有方法必须都hook了，才能保证`NSArray`的操作不崩溃
         */
        Class array0Class = objc_getClass("__NSArray0");
        Class arrayOneClass = objc_getClass("__NSSingleObjectArrayI");
        Class arrayIClass = objc_getClass("__NSArrayI");
        /********** NSArray: 取元素 **********/
        // [array objectAtIndex:1000] 方式发生的crash
        [self miSwizzleInstanceMethod:array0Class
                             swizzSel:@selector(objectAtIndex:)
                        toSwizzledSel:@selector(miArr0ObjectAtIndex:)];
        [self miSwizzleInstanceMethod:arrayOneClass
                             swizzSel:@selector(objectAtIndex:)
                        toSwizzledSel:@selector(miArrOneObjectAtIndex:)];
        [self miSwizzleInstanceMethod:arrayIClass
                             swizzSel:@selector(objectAtIndex:)
                        toSwizzledSel:@selector(miArrObjectAtIndex:)];
        // array[10000] 方式发生的crash (仅仅只需要hook `__NSArrayI`)
        [self miSwizzleInstanceMethod:arrayIClass
                             swizzSel:@selector(objectAtIndexedSubscript:)
                        toSwizzledSel:@selector(miArrObjectAtIndexSubscript:)];
        
        // [array getObjects:range:] 方式发生crash ,此时只需要hook `NSArray`,`__NSArrayI`,`__NSSingleObjectArrayI`
        Class nsarrayClass = objc_getClass("NSArray");
        [self miSwizzleInstanceMethod:nsarrayClass
                             swizzSel:@selector(getObjects:range:)
                        toSwizzledSel:@selector(miGetNSArrayObjects:range:)];
        [self miSwizzleInstanceMethod:arrayOneClass
                             swizzSel:@selector(getObjects:range:)
                        toSwizzledSel:@selector(miGetOneArrayObjects:range:)];
        [self miSwizzleInstanceMethod:arrayIClass
                             swizzSel:@selector(getObjects:range:)
                        toSwizzledSel:@selector(miGetArrayIObjects:range:)];
        
        
        /**************************************** NSArrayMutableArray 操作 ****************************************/
        Class mutaArrayClass = objc_getClass("__NSArrayM");
        // 取元素
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(objectAtIndex:)
                        toSwizzledSel:@selector(miMutaArrObjectAtIndex:)];
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(objectAtIndexedSubscript:)
                        toSwizzledSel:@selector(miMutaArrObjectAtIndexSubscript:)];
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(getObjects:range:)
                        toSwizzledSel:@selector(miGetMutaArrayObjects:range:)];
        
        // 添加元素
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(setObject:atIndexedSubscript:)
                        toSwizzledSel:@selector(miSetObject:atIndexedSubscript:)];
        
        // 插入元素： 元素为nil; index非法
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(insertObject:atIndex:)
                        toSwizzledSel:@selector(miMutaInsertObject:atIndex:)];
        
        /********** 删除元素 **********/
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(removeObjectsInRange:)
                        toSwizzledSel:@selector(miRemoveObjectsInRange:)];
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(removeObject:inRange:)
                        toSwizzledSel:@selector(miRemoveObject:inRange:)];
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(removeObjectIdenticalTo:inRange:)
                        toSwizzledSel:@selector(miRemoveObjectIdenticalTo:inRange:)];
        
        /********** 替换数组中元素 **********/
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(replaceObjectAtIndex:withObject:)
                        toSwizzledSel:@selector(miReplaceObjectAtIndex:withObject:)];
        
        /********** 交换数组中元素 **********/
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(exchangeObjectAtIndex:withObjectAtIndex:)
                        toSwizzledSel:@selector(miExchangeObjectAtIndex:withObjectAtIndex:)];
        /********** 替换元素 **********/
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(replaceObjectsInRange:withObjectsFromArray:range:)
                        toSwizzledSel:@selector(miReplaceObjectsInRange:withObjectsFromArray:range:)];
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(replaceObjectsInRange:withObjectsFromArray:)
                        toSwizzledSel:@selector(miReplaceObjectsInRange:withObjectsFromArray:)];
        
        [self miSwizzleInstanceMethod:mutaArrayClass
                             swizzSel:@selector(integerValue)
                        toSwizzledSel:@selector(miIntegerValue)];
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
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSPlaceholderArray)[initWithObjects:count:] crash , remove nil elements"];
        BOOL hasNilObject = NO;
        for (NSUInteger i = 0; i < cnt; i++) {
            if ([objects[i] isKindOfClass:[NSArray class]]) {
                NSLog(@"%@", objects[i]);
            }
            if (objects[i] == nil) {
                hasNilObject = YES;
            }
        }
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
- (id)miArr0ObjectAtIndex:(NSUInteger)index
{
    id ele = nil;
    @try {
        ele = [self miArr0ObjectAtIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArray0)[objectAtIndex:] crash , return nil"];
    } @finally {
        return ele;
    }
}

- (id)miArrOneObjectAtIndex:(NSUInteger)index
{
    id ele = nil;
    @try {
        ele = [self miArrOneObjectAtIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSSingleObjectArrayI)[objectAtIndex:] crash , return nil"];
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
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayI)[objectAtIndex:] crash , return nil"];
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
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[objectAtIndex:] crash , return nil"];
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
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayI)[objectAtIndexedSubscript:] crash , return nil"];
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
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[objectAtIndexedSubscript:] crash , return nil"];
    } @finally {
        return ele;
    }
}

- (void)miGetNSArrayObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
{
    @try {
        [self miGetNSArrayObjects:objects range:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(NSArray)[getObjects:range:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miGetOneArrayObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
{
    @try {
        [self miGetOneArrayObjects:objects range:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSSingleObjectArrayI)[getObjects:range:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miGetArrayIObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
{
    @try {
        [self miGetArrayIObjects:objects range:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayI)[getObjects:range:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miGetMutaArrayObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
{
    @try {
        [self miGetMutaArrayObjects:objects range:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[getObjects:range:] crash , ignore this method operation"];
    } @finally {}
}
#pragma mark - 添加元素
- (void)miSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    @try {
        [self miSetObject:obj atIndexedSubscript:idx];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[setObject:atIndexedSubscript:] crash , ignore this method operation"];
    } @finally {}
}

#pragma mark - 插入元素
- (void)miMutaInsertObject:(id)object atIndex:(NSUInteger)index
{
    @try {
        [self miMutaInsertObject:object atIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[insertObject:atIndex:] crash , ignore this method operation"];
    } @finally {}
}

#pragma mark - 删除元素
- (void)miRemoveObjectsInRange:(NSRange)range
{
    @try {
        [self miRemoveObjectsInRange:range];
    } @catch (NSException *exception) {
         [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[removeObjectsInRange:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miRemoveObject:(id)anObject inRange:(NSRange)range
{
    @try {
         [self miRemoveObject:anObject inRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[removeObject:inRange:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miRemoveObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    @try {
        [self miRemoveObjectIdenticalTo:anObject inRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[removeObjectIdenticalTo:inRange:] crash , ignore this method operation"];
    } @finally {}
}

#pragma mark - 替换元素
- (void)miReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @try {
        [self miReplaceObjectAtIndex:index withObject:anObject];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[replaceObjectAtIndex:withObject:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(id)otherArray range:(NSRange)otherRange
{
    @try {
        [self miReplaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[replaceObjectsInRange:withObjectsFromArray:range:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(id)otherArray
{

    @try {
        [self miReplaceObjectsInRange:range withObjectsFromArray:otherArray];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[replaceObjectsInRange:withObjectsFromArray:] crash , ignore this method operation"];
    } @finally {}
}

#pragma mark - 交换元素
- (void)miExchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    @try {
        [self miExchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[exchangeObjectAtIndex:withObjectAtIndex:] crash , ignore this method operation"];
    } @finally {}
}

- (NSInteger)miIntegerValue
{
    NSInteger iV = 0;
    @try {
       iV = [self miIntegerValue];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSArray crashDes:@"(__NSArrayM)[integerValue] crash , return 0"];
    } @finally {
        return iV;
    }
}


@end
