//
//  PersonObserver.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/26.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "PersonObserver.h"

@implementation PersonObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"age"]) {
        Class classInfo = (__bridge Class)context;
        NSString *className = [NSString stringWithCString:object_getClassName(classInfo) encoding:NSUTF8StringEncoding];
        
        NSLog(@" >> class: %@, Age changed", className);
        NSLog(@" old age is %@", [change objectForKey:@"old"]);
        NSLog(@" new age is %@", [change objectForKey:@"new"]);
    }else if([keyPath isEqualToString:@"name"])
    {
        Class classInfo = (__bridge Class)context;
        NSString *className = [NSString stringWithCString:object_getClassName(classInfo) encoding:NSUTF8StringEncoding];
        NSLog(@" >> class: %@, name changed", className);
        NSLog(@" old name is %@", [change objectForKey:@"old"]);
        NSLog(@" new name is %@", [change objectForKey:@"new"]);

    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
