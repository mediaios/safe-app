//
//  NSAttributedString+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/23.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSAttributedString+MiSafe.h"
#import "NSObject+MiSafe.h"
#import <objc/runtime.h>

@implementation NSAttributedString (MiSafe)

+ (void)load
{
    static dispatch_once_t miOnceToken;
    dispatch_once(&miOnceToken, ^{
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteAttributedString")
                                 swizzSel:@selector(initWithString:)
                            toSwizzledSel:@selector(miInitWithString:)];
        
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(initWithString:)
                            toSwizzledSel:@selector(miInitMutaASWithString:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(initWithString:attributes:)
                            toSwizzledSel:@selector(miInitMutaASWithString:attributes:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(replaceCharactersInRange:withString:)
                            toSwizzledSel:@selector(miReplaceCharactersInRange:withString:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(setAttributes:range:)
                            toSwizzledSel:@selector(miSetAttributes:range:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(addAttribute:value:range:)
                            toSwizzledSel:@selector(miAddAttribute:value:range:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(addAttributes:range:)
                            toSwizzledSel:@selector(miAddAttributes:range:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(removeAttribute:range:)
                            toSwizzledSel:@selector(miRemoveAttribute:range:)];
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(replaceCharactersInRange:withAttributedString:)
                            toSwizzledSel:@selector(miReplaceCharactersInRange:withAttributedString:)];
    });
}

- (instancetype)miInitWithString:(NSString *)str
{
    if (str) {
        return [self miInitWithString:str];
    }
    return nil;
}

- (instancetype)miInitMutaASWithString:(NSString *)str
{
    if (str) {
        return [self miInitMutaASWithString:str];
    }
    return nil;
}

- (instancetype)miInitMutaASWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs
{
    if (str) {
        return [self miInitMutaASWithString:str attributes:attrs];
    }
    return nil;
}

- (void)miReplaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    if ((range.location + range.length) > self.length) {
        return;
    }
    [self miReplaceCharactersInRange:range withString:str];
}

- (void)miSetAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range
{
    if ((range.location + range.length) > self.length) {
        return;
    }
    [self miSetAttributes:attrs range:range];
}

- (void)miAddAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range
{
    if ((range.location + range.length) > self.length) {
        return;
    }
    [self miAddAttribute:name value:value range:range];
}

- (void)miAddAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range
{
    if ((range.location + range.length) > self.length) {
        return;
    }
    [self miAddAttributes:attrs range:range];
}

- (void)miRemoveAttribute:(NSAttributedStringKey)name range:(NSRange)range
{
    if ((range.location + range.length) > self.length) {
        return;
    }
    [self miRemoveAttribute:name range:range];
}

- (void)miReplaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString
{
    if ((range.location + range.length) > self.length || !attrString) {
        return;
    }
    [self miReplaceCharactersInRange:range withAttributedString:attrString];
}



@end
