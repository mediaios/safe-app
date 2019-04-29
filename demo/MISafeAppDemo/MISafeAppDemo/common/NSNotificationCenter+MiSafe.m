//
//  NSNotificationCenter+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/29.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSNotificationCenter+MiSafe.h"
#import "NSObject+MiSafe.h"
#import <objc/message.h>

@interface NSObject (MiSafeNotification)
@property (nonatomic,assign) BOOL isNoti;  // 用于标记NSObject兑现是否是监听了通知的对象
@end

@implementation NSObject (MiSafeNotification)

- (void)setIsNoti:(BOOL)isNoti
{
    objc_setAssociatedObject(self, @selector(isNoti), @(isNoti), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isNoti
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

// 声明一个变量，存储已经remove通知的observer
static NSMutableSet *miSafeRemovedNotiObjs()
{
    static NSMutableSet *rmNotiObjs = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rmNotiObjs = [[NSMutableSet alloc] init];
    });
    return rmNotiObjs;
}

- (void)mi_NotiDealloc
{
    if ([self isNoti]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

// dealloc的处理逻辑
- (void)miExchangeDealloc
{
    Class objClass = [self class];
    @synchronized (miSafeRemovedNotiObjs()) {
        NSString *className = NSStringFromClass(objClass);
        if ([miSafeRemovedNotiObjs() containsObject:className]) {
            return;
        }
        
        SEL deallocSel = sel_registerName("dealloc");
        
        __block void (*oldDealloc)(__unsafe_unretained id, SEL) = NULL;
        id newDealloc = ^(__unsafe_unretained id self){
            [self mi_NotiDealloc];
            if (oldDealloc == NULL) {
                struct objc_super superInfo = {
                    .receiver = self,
                    .super_class = class_getSuperclass(objClass)
                };
                void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                msgSend(&superInfo,deallocSel);
            }else{
                oldDealloc(self,deallocSel);
            }
        };
        
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        BOOL isAdded = class_addMethod(objClass, deallocSel, newDeallocIMP, "v@:");
        if (!isAdded) {
            Method deallocMethod = class_getInstanceMethod(objClass, deallocSel);
            oldDealloc = (__typeof__(oldDealloc))method_getImplementation(deallocMethod);
            oldDealloc = (__typeof__(oldDealloc))method_setImplementation(deallocMethod, newDeallocIMP);
        }
        [miSafeRemovedNotiObjs() addObject:className];
    }
}
@end


@implementation NSNotificationCenter (MiSafe)

+ (void)miOpenNotificationMiSafe
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self miSwizzleInstanceMethod:[NSNotificationCenter class]
                             swizzSel:@selector(addObserver:selector:name:object:)
                        toSwizzledSel:@selector(miNotiAddObserver:selector:name:object:)];
        
    });
}

- (void)miNotiAddObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject
{
    [observer setIsNoti:YES];
    [observer miExchangeDealloc];
    [self miNotiAddObserver:observer selector:aSelector name:aName object:anObject];
}

@end
