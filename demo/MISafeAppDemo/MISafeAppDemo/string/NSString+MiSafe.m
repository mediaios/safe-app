//
//  NSString+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/23.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSString+MiSafe.h"
#import "NSObject+MiSafe.h"
#import <objc/runtime.h>
#import "MiSafeApp.h"

@implementation NSString (MiSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self miSwizzleInstanceMethod:objc_getClass("NSPlaceholderString")
                                 swizzSel:@selector(initWithString:)
                            toSwizzledSel:@selector(miInitWithString:)];
        Class class_init =  NSClassFromString(@"__NSCFConstantString");
        Class class_class = NSClassFromString(@"NSTaggedPointerString");
        [self miSwizzleMethods:class_init];
        [self miSwizzleMethods:class_class];
    });
}

+ (void)miSwizzleMethods:(Class)class
{
    [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(substringFromIndex:)
                        toSwizzledSel:@selector(miSubstringFromIndex:)];
    [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(substringToIndex:)
                        toSwizzledSel:@selector(miSubstringToIndex:)];
    [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(substringWithRange:)
                        toSwizzledSel:@selector(miSubstringWithRange:)];
    [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(characterAtIndex:)
                        toSwizzledSel:@selector(miCharacterAtIndex:)];
    [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                        toSwizzledSel:@selector(miStringByReplacingOccurrencesOfString:withString:options:range:)];
    [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(stringByReplacingCharactersInRange:withString:)
                        toSwizzledSel:@selector(miStringByReplacingCharactersInRange:withString:)];
    [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(hasPrefix:)
                        toSwizzledSel:@selector(miHasPrefix:)];
    [self miSwizzleInstanceMethod:class
                             swizzSel:@selector(hasSuffix:)
                        toSwizzledSel:@selector(miHasSuffix:)];
}

- (NSString *)miSubstringFromIndex:(NSUInteger)from
{
    NSString *str = nil;
    @try {
        str = [self miSubstringFromIndex:from];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[substringFromIndex:] crash , return nil"];
    } @finally {
        return str;
    }
}

- (instancetype)miInitWithString:(NSString *)aString
{
    id str = nil;
    @try {
        str = [self miInitWithString:aString];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[initWithString:] crash , return nil"];
    } @finally {
        return str;
    }
}

- (NSString *)miSubstringToIndex:(NSUInteger)to
{
    if (to > self.length) {
        NSException *exception = [NSException exceptionWithName:@"MINSStringException" reason:@"[substringToIndex:], range invalid" userInfo:@{@"errorInfo":@"substringToIndex:range invalid"}];
         [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[substringToIndex:] crash , return nil"];
        return nil;
    }
    return [self miSubstringToIndex:to];
}

- (NSString *)miSubstringWithRange:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self miSubstringWithRange:range];
    }else if(range.location < self.length){
        return [self miSubstringWithRange:NSMakeRange(range.location, self.length-range.location)];
    }
    NSException *exception = [NSException exceptionWithName:@"MINSStringException" reason:@"[substringWithRange:], range invalid" userInfo:@{@"errorInfo":@"substringWithRange: range invalid"}];
    [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[substringWithRange:] crash , return nil"];
    return nil;
}

- (unichar)miCharacterAtIndex:(NSUInteger)index
{
    
    unichar characteristic;
    @try {
        characteristic = [self miCharacterAtIndex:index];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[characterAtIndex:] crash , return 0"];
    }
    @finally {
        return characteristic;
    }
}

- (NSString *)miStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    NSString *str = nil;
    @try {
        str = [self miStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[stringByReplacingOccurrencesOfString:withString:options:range:] crash , return nil"];
    } @finally {
        return str;
    }
}

- (NSString *)miStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    NSString *str = nil;
    @try {
        str = [self miStringByReplacingCharactersInRange:range withString:replacement];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[stringByReplacingCharactersInRange:withString:] crash , return nil"];
    } @finally {
        return str;
    }
}

- (BOOL)miHasPrefix:(NSString *)str
{
    if (!str) {
        NSException *exception = [NSException exceptionWithName:@"MINSStringException" reason:@"[hasPrefix:], prefix is nil" userInfo:@{@"errorInfo":@"hasPrefix: prefix is nil"}];
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[hasPrefix:] crash , return NO"];
        return NO;
    }
    return [self miHasPrefix:str];
}

- (BOOL)miHasSuffix:(NSString *)str
{
    if (!str) {
        NSException *exception = [NSException exceptionWithName:@"MINSStringException" reason:@"[hasSuffix:], suffix is nil" userInfo:@{@"errorInfo":@"hasSuffix: suffix is nil"}];
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSString crashDes:@"(NSString)[hasSuffix:] crash , return NO"];
        return NO;
    }
    return [self miHasSuffix:str];
}


@end
