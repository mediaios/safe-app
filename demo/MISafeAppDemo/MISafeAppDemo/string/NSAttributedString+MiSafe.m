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
#import "MiSafeApp.h"

@implementation NSAttributedString (MiSafe)

+ (void)load
{
    static dispatch_once_t miOnceToken;
    dispatch_once(&miOnceToken, ^{
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteAttributedString")
                                 swizzSel:@selector(initWithString:)
                            toSwizzledSel:@selector(miInitWithString:)];
        
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(initWithString:)
                            toSwizzledSel:@selector(miInitMutaASWithString:)];
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(initWithString:attributes:)
                            toSwizzledSel:@selector(miInitMutaASWithString:attributes:)];
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(replaceCharactersInRange:withString:)
                            toSwizzledSel:@selector(miReplaceCharactersInRange:withString:)];
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(setAttributes:range:)
                            toSwizzledSel:@selector(miSetAttributes:range:)];
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(addAttribute:value:range:)
                            toSwizzledSel:@selector(miAddAttribute:value:range:)];
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(addAttributes:range:)
                            toSwizzledSel:@selector(miAddAttributes:range:)];
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(removeAttribute:range:)
                            toSwizzledSel:@selector(miRemoveAttribute:range:)];
        [self miSwizzleInstanceMethod:objc_getClass("NSConcreteMutableAttributedString")
                                 swizzSel:@selector(replaceCharactersInRange:withAttributedString:)
                            toSwizzledSel:@selector(miReplaceCharactersInRange:withAttributedString:)];
    });
}

- (instancetype)miInitWithString:(NSString *)str
{
    id instance = nil;
    @try {
        instance = [self miInitWithString:str];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
        instance = nil;
    } @finally {
        return instance;
    }
}

- (instancetype)miInitMutaASWithString:(NSString *)str
{
    id instance = nil;
    @try {
        instance = [self miInitMutaASWithString:str];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
        instance = nil;
    } @finally {
        return instance;
    }
}

- (instancetype)miInitMutaASWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs
{
    id instance = nil;
    @try {
        instance = [self miInitMutaASWithString:str attributes:attrs];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
        instance = nil;
    } @finally {
        return instance;
    }
}

- (void)miReplaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    @try {
        [self miReplaceCharactersInRange:range withString:str];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
    
}

- (void)miSetAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range
{
    
    @try{
        [self miSetAttributes:attrs range:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miAddAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range
{
    @try{
        [self miAddAttribute:name value:value range:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miAddAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range
{
    @try{
        [self miAddAttributes:attrs range:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}

- (void)miRemoveAttribute:(NSAttributedStringKey)name range:(NSRange)range
{
    @try{
        [self miRemoveAttribute:name range:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
    
}

- (void)miReplaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString
{
    @try{
        [self miReplaceCharactersInRange:range withAttributedString:attrString];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    } @finally {}
}



@end
