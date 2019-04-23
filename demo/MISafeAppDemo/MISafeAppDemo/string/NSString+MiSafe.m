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

@implementation NSString (MiSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject miSwizzleInstanceMethod:objc_getClass("NSPlaceholderString")
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
    [NSObject miSwizzleInstanceMethod:class
                             swizzSel:@selector(substringFromIndex:)
                        toSwizzledSel:@selector(miSubstringFromIndex:)];
    [NSObject miSwizzleInstanceMethod:class
                             swizzSel:@selector(substringToIndex:)
                        toSwizzledSel:@selector(miSubstringToIndex:)];
    [NSObject miSwizzleInstanceMethod:class
                             swizzSel:@selector(substringWithRange:)
                        toSwizzledSel:@selector(miSubstringWithRange:)];
    [NSObject miSwizzleInstanceMethod:class
                             swizzSel:@selector(characterAtIndex:)
                        toSwizzledSel:@selector(miCharacterAtIndex:)];
    [NSObject miSwizzleInstanceMethod:class
                             swizzSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                        toSwizzledSel:@selector(miStringByReplacingOccurrencesOfString:withString:options:range:)];
    [NSObject miSwizzleInstanceMethod:class
                             swizzSel:@selector(stringByReplacingCharactersInRange:withString:)
                        toSwizzledSel:@selector(miStringByReplacingCharactersInRange:withString:)];
    [NSObject miSwizzleInstanceMethod:class
                             swizzSel:@selector(hasPrefix:)
                        toSwizzledSel:@selector(miHasPrefix:)];
    [NSObject miSwizzleInstanceMethod:class
                             swizzSel:@selector(hasSuffix:)
                        toSwizzledSel:@selector(miHasSuffix:)];
}

- (NSString *)miSubstringFromIndex:(NSUInteger)from
{
    if (from >= self.length) {
        return nil;
    }
    return [self miSubstringFromIndex:from];
}

- (instancetype)miInitWithString:(NSString *)aString
{
    if (!aString) {
        return nil;
    }
    return [self miInitWithString:aString];
}

- (NSString *)miSubstringToIndex:(NSUInteger)to
{
    if (to > self.length) {
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
    return nil;
}

- (unichar)miCharacterAtIndex:(NSUInteger)index
{
    if (index >= self.length) {
        return 0;
    }
    return [self miCharacterAtIndex:index];
}

- (NSString *)miStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    NSString *str = nil;
    @try {
        str = [self miStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    } @catch (NSException *exception) {
        str = nil;
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
        str = nil;
    } @finally {
        return str;
    }
}

- (BOOL)miHasPrefix:(NSString *)str
{
    if (!str) {
        return NO;
    }
    return [self hasPrefix:str];
}

- (BOOL)miHasSuffix:(NSString *)str
{
    if (!str) {
        return NO;
    }
    return [self miHasSuffix:str];
}



@end
