//
//  NSSet+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/28.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSSet+MiSafe.h"
#import "NSObject+MiSafe.h"
#import <objc/runtime.h>
#import "MiSafeApp.h"

@implementation NSSet (MiSafe)

+ (void)miOpenNSSetMiSafe
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class placeholderset = NSClassFromString(@"__NSPlaceholderSet");
        [self miSwizzleInstanceMethod:placeholderset
                             swizzSel:@selector(initWithObjects:count:)
                        toSwizzledSel:@selector(miSetInitWithObjects:count:)];
        
        
        Class mutaSetClass = NSClassFromString(@"__NSSetM");
        [self miSwizzleInstanceMethod:mutaSetClass
                             swizzSel:@selector(addObject:)
                        toSwizzledSel:@selector(miSetAddObject:)];
        [self miSwizzleInstanceMethod:mutaSetClass
                             swizzSel:@selector(removeObject:)
                        toSwizzledSel:@selector(miSetRemoveObject:)];
        
        
        
    });
}


#pragma mark - init NSSet
- (instancetype)miSetInitWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt
{
    id instance = nil;
    @try {
        instance = [self miSetInitWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        NSInteger newObjsIndex = 0;
        id   newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self miSetInitWithObjects:newObjects count:newObjsIndex];
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {
        return instance;
    }
}

#pragma mark - NSMutableSet
- (void)miSetAddObject:(id)object
{
    @try {
        [self miSetAddObject:object];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miSetRemoveObject:(id)object
{
    
    @try {
        [self miSetRemoveObject:object];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {
        
    }
}


@end
