//
//  NSOrderedSet+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/28.
//  Copyright © 2019年 mediaios. All rights reserved.
//

#import "NSOrderedSet+MiSafe.h"
#import "NSObject+MiSafe.h"
#import "MiSafeApp.h"
#import <objc/runtime.h>

@implementation NSOrderedSet (MiSafe)
+ (void)miOpenNSOrderedSetMiSafe
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class placeHolderOSet = NSClassFromString(@"__NSPlaceholderOrderedSet");
        [self miSwizzleInstanceMethod:placeHolderOSet
                             swizzSel:@selector(initWithObjects:count:)
                        toSwizzledSel:@selector(miOrderedSetInitWithObjects:count:)];
        
        Class orderedSetI = NSClassFromString(@"__NSOrderedSetI");
        [self miSwizzleInstanceMethod:orderedSetI
                             swizzSel:@selector(objectAtIndex:)
                        toSwizzledSel:@selector(miOrderedSetObjectAtIndex:)];
        
        Class mutaOrderedSetM = NSClassFromString(@"__NSOrderedSetM");
        [self miSwizzleInstanceMethod:mutaOrderedSetM
                             swizzSel:@selector(objectAtIndex:)
                        toSwizzledSel:@selector(miMutaOSetObjectAtIndex:)];
        [self miSwizzleInstanceMethod:mutaOrderedSetM
                             swizzSel:@selector(insertObject:atIndex:)
                        toSwizzledSel:@selector(miMutaOSetInsertObject:atIndex:)];
        [self miSwizzleInstanceMethod:mutaOrderedSetM
                             swizzSel:@selector(removeObjectAtIndex:)
                        toSwizzledSel:@selector(miMutaOSetRemoveObjectAtIndex:)];
        [self miSwizzleInstanceMethod:mutaOrderedSetM
                             swizzSel:@selector(replaceObjectAtIndex:withObject:)
                        toSwizzledSel:@selector(miMutaOSetReplaceObjectAtIndex:withObject:)];
        [self miSwizzleInstanceMethod:mutaOrderedSetM
                             swizzSel:@selector(addObject:)
                        toSwizzledSel:@selector(miMutaOSetAddObject:)];
    });
}

#pragma mark - NSOrderedSet
- (instancetype)miOrderedSetInitWithObjects:(id _Nonnull const [])objects count:(NSUInteger)cnt
{
    id orderedSet = nil;
    @try {
        orderedSet = [self miOrderedSetInitWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        NSInteger index = 0;
        id newObjects[cnt];
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[index] = objects[i];
                index++;
            }
        }
        orderedSet = [self miOrderedSetInitWithObjects:newObjects count:index];
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSSet crashDes:@"(__NSPlaceholderOrderedSet)[initWithObjects:count:] crash , remove nil elements"];
    } @finally {
        return orderedSet;
    }
}

- (id)miOrderedSetObjectAtIndex:(NSUInteger)idx
{
    id obj = nil;
    @try {
        obj = [self miOrderedSetObjectAtIndex:idx];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSSet crashDes:@"(__NSOrderedSetI)[objectAtIndex:] crash , return nil"];
    } @finally {
        return obj;
    }
}

#pragma mark - NSMutableOrderedSet
- (id)miMutaOSetObjectAtIndex:(NSUInteger)idx
{
    id obj = nil;
    @try {
        obj = [self miMutaOSetObjectAtIndex:idx];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSSet crashDes:@"(__NSOrderedSetM)[objectAtIndex:] crash , return nil"];
    } @finally {
        return obj;
    }
}

- (void)miMutaOSetInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    @try {
        [self miMutaOSetInsertObject:anObject atIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSSet crashDes:@"(__NSOrderedSetM)[insertObject:atIndex:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miMutaOSetRemoveObjectAtIndex:(NSUInteger)index
{
    @try {
        [self miMutaOSetRemoveObjectAtIndex:index];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSSet crashDes:@"(__NSOrderedSetM)[removeObjectAtIndex:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miMutaOSetReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @try {
        [self miMutaOSetReplaceObjectAtIndex:index withObject:anObject];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSSet crashDes:@"(__NSOrderedSetM)[replaceObjectAtIndex:withObject:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miMutaOSetAddObject:(id)object
{
    @try {
        [self miMutaOSetAddObject:object];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSSet crashDes:@"(__NSOrderedSetM)[addObject:] crash , ignore this method operation"];
    } @finally {}
}
@end
