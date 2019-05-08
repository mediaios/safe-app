//
//  NSTimer+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/30.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSTimer+MiSafe.h"
#import "NSObject+MiSafe.h"
#import <objc/runtime.h>

@interface MiSafeTimerProxy:NSObject
@property (nonatomic,weak) id target;
@property (nonatomic,assign) SEL selector;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation MiSafeTimerProxy

- (void)miFire:(NSTimer *)timer
{
    if (self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer.userInfo];
#pragma clang diagnostic pop
    }else{
        [self.timer invalidate];
    }
}

@end


@implementation NSTimer (MiSafe)

+ (void)miOpenNSTimerMiSafe
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self miSwizzleClassMethodWithClass:[NSTimer class]
                                   swizzSel:@selector(timerWithTimeInterval:target:selector:userInfo:repeats:)
                              toSwizzledSel:@selector(miTimerWithTimeInterval:target:selector:userInfo:repeats:)];
    });
    
}


+ (NSTimer *)miTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    MiSafeTimerProxy *tProxy = [MiSafeTimerProxy new];
    tProxy.target = aTarget;
    tProxy.selector = aSelector;
    tProxy.timer = [NSTimer miTimerWithTimeInterval:ti
                                             target:tProxy
                                           selector:@selector(miFire:)
                                           userInfo:userInfo
                                            repeats:yesOrNo];
    
    return tProxy.timer;
}

@end
