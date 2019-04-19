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
+ (void)miSwizzleInstanceMethod:(Class)class swizzSel:(SEL)originSel toSwizzledSel:(SEL)swizzledSel;
@end

NS_ASSUME_NONNULL_END
