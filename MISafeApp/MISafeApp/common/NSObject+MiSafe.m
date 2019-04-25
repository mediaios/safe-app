//
//  NSObject+MiSafe.m
//  MISafeApp
//
//  Created by mediaios on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSObject+MiSafe.h"
#import <objc/runtime.h>

@implementation NSObject (MiSafe)

+ (void)miSwizzleInstanceMethod:(Class)class
                       swizzSel:(SEL)originSel
                  toSwizzledSel:(SEL)swizzledSel
{
    Method originMethod   =  class_getInstanceMethod(class, originSel);
    Method swizzledMethod =  class_getInstanceMethod(class, swizzledSel);
    BOOL didAddMethod = class_addMethod(class,
                                        originSel,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSel,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

+ (void)miSwizzleClassMethodWithClass:(Class)class
                             swizzSel:(SEL)originSel
                        toSwizzledSel:(SEL)swizzledSel
{
    Method originMethod  = class_getClassMethod(class, originSel);
    Method swizzledMethod = class_getClassMethod(class, swizzledSel);
    if (!originMethod || !swizzledMethod) {
        return;
    }
    IMP originImp = method_getImplementation(originMethod);
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    const char * originType = method_getTypeEncoding(originMethod);
    const char * swizzledTye = method_getTypeEncoding(swizzledMethod);
    
    // 添加方法到元类中
    Class metaClass = objc_getMetaClass(class_getName(class));
    class_replaceMethod(metaClass, swizzledSel, originImp, originType);
    class_replaceMethod(metaClass, originSel, swizzledImp, swizzledTye);
}

@end
