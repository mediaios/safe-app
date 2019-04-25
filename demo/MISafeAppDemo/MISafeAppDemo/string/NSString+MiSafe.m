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
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
        str = nil;
    } @finally {
        return str;
    }
    
//    if (from >= self.length) {
//        return nil;
//    }
//    return [self miSubstringFromIndex:from];
}

- (instancetype)miInitWithString:(NSString *)aString
{
    id str = nil;
    @try {
        str = [self miInitWithString:aString];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    } @finally {
        return str;
    }
    
    
//    if (!aString) {
//        return nil;
//    }
//    return [self miInitWithString:aString];
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
    
    unichar characteristic;
    @try {
        characteristic = [self miCharacterAtIndex:index];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    }
    @finally {
        return characteristic;
    }
    
    
//    if (index >= self.length) {
//        return 0;
//    }
//    return [self miCharacterAtIndex:index];
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
    return [self miHasPrefix:str];
}

- (BOOL)miHasSuffix:(NSString *)str
{
    if (!str) {
        return NO;
    }
    return [self miHasSuffix:str];
}

#pragma mark - NSMutableString特有的

-(void)miReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString
{
    @try {
        [self miReplaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


-(NSUInteger)miReplaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    NSUInteger index=0;
    @try {
        index= [self miReplaceOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        return index;
    }
}



-(void)miInsertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    @try {
        [self miInsertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


-(void)miDeleteCharactersInRange:(NSRange)range
{
    @try {
        [self miDeleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


-(void)miAppendString:(NSString *)aString
{
    @try {
        [self miAppendString:aString];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}

-(void)miSetString:(NSString *)aString
{
    @try {
        [self miSetString:aString];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}






@end
