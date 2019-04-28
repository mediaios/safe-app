//
//  NSObject+MiSafe.h
//  MISafeApp
//
//  Created by mediaios on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MiSafe)

/**
 交换对象方法

 @param class 被替换的方法所属的类
 @param originSel 需要被替换的方法
 @param swizzledSel 被替换成的方法
 */
+ (void)miSwizzleInstanceMethod:(Class)class swizzSel:(SEL)originSel toSwizzledSel:(SEL)swizzledSel;


/**
 交换类方法

 @param class 被替换的方法所属的类
 @param originSel 需要被替换的方法
 @param swizzledSel 被替换成的方法
 */
+ (void)miSwizzleClassMethodWithClass:(Class)class swizzSel:(SEL)originSel toSwizzledSel:(SEL)swizzledSel;

@end

NS_ASSUME_NONNULL_END
