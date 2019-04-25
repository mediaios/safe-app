//
//  NSMutableString+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/23.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSMutableString+MiSafe.h"
#import "NSObject+MiSafe.h"
#import <objc/runtime.h>
#import "MiSafeApp.h"
@implementation NSMutableString (MiSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class mutaPlaceHolder = objc_getClass("NSPlaceholderMutableString");
        [self miSwizzleInstanceMethod:mutaPlaceHolder
                                 swizzSel:@selector(initWithString:)
                            toSwizzledSel:@selector(miInitWithString:)];
        [self miSwizzleInstanceMethod:mutaPlaceHolder
                                 swizzSel:@selector(initWithCString:encoding:)
                            toSwizzledSel:@selector(miInitWithCString:encoding:)];
        [self miSwizzleInstanceMethod:mutaPlaceHolder
                                 swizzSel:@selector(initWithUTF8String:)
                            toSwizzledSel:@selector(miInitWithUTF8String:)];
        
        Class strClass = NSClassFromString(@"__NSCFString");
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(hasPrefix:)
                            toSwizzledSel:@selector(miCFStrHasPrefix:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(hasSuffix:)
                            toSwizzledSel:@selector(miCFStrHasSuffix:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(substringFromIndex:)
                            toSwizzledSel:@selector(miCFStrSubstringFromIndex:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(substringToIndex:)
                            toSwizzledSel:@selector(miCFStrSubstringToIndex:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(substringWithRange:)
                            toSwizzledSel:@selector(miCFStrSubstringWithRange:)];
        
        
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(characterAtIndex:)
                            toSwizzledSel:@selector(miCFStrCharacterAtIndex:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                            toSwizzledSel:@selector(miCFStrStringByReplacingOccurrencesOfString:withString:options:range:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(stringByReplacingCharactersInRange:withString:)
                            toSwizzledSel:@selector(miCFStrStringByReplacingCharactersInRange:withString:)];
        
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(replaceCharactersInRange:withString:)
                            toSwizzledSel:@selector(miReplaceCharactersInRange:withString:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(replaceOccurrencesOfString:withString:options:range:)
                            toSwizzledSel:@selector(miReplaceOccurrencesOfString:withString:options:range:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(insertString:atIndex:)
                            toSwizzledSel:@selector(miInsertString:atIndex:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(deleteCharactersInRange:)
                            toSwizzledSel:@selector(miDeleteCharactersInRange:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(appendString:)
                            toSwizzledSel:@selector(miAppendString:)];
        [self miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(setString:)
                            toSwizzledSel:@selector(miSetString:)];
    });
}

-(instancetype)miInitWithString:(NSString *)aString
{
    id instance = nil;
    @try {
        instance = [self miInitWithString:aString];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    }
    @finally {
        return instance;
    }
}


-(BOOL)miCFStrHasPrefix:(NSString *)str
{
    BOOL has = NO;
    @try {
        has = [self miCFStrHasPrefix:str];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    }
    @finally {
        return has;
    }
}

-(BOOL)miCFStrHasSuffix:(NSString *)str
{
    BOOL has = NO;
    @try {
        has = [self miCFStrHasSuffix:str];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    }
    @finally {
        return has;
    }
}

- (NSString *)miCFStrSubstringFromIndex:(NSUInteger)from {
    
    NSString *subString = nil;
    @try {
        subString = [self miCFStrSubstringFromIndex:from];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (NSString *)miCFStrSubstringToIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self miCFStrSubstringToIndex:index];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (NSString *)miCFStrSubstringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    @try {
        subString = [self miCFStrSubstringWithRange:range];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (unichar)miCFStrCharacterAtIndex:(NSUInteger)index {

    unichar characteristic;
    @try {
        characteristic = [self miCFStrCharacterAtIndex:index];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    }
    @finally {
        return characteristic;
    }
}


- (NSString *)miCFStrStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self miCFStrStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


- (NSString *)miCFStrStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    @try {
        newStr = [self miCFStrStringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

#pragma mark - NSPlaceholderMutableString
//- (instancetype)miInitWithString:(NSString *)aString
//{
//    id str = nil;
//    @try {
//        str = [self miInitWithString:aString];
//    } @catch (NSException *exception) {
//        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
//    } @finally {
//        return str;
//    }
//}

- (instancetype)miInitWithUTF8String:(const char *)nullTerminatedCString
{
    id str = nil;
    @try {
        str = [self miInitWithUTF8String:nullTerminatedCString];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    } @finally {
        return str;
    }
}

- (instancetype)miInitWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding
{
    id str = nil;
    @try {
        str = [self miInitWithCString:nullTerminatedCString encoding:encoding];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_ReturnNil];
    } @finally {
        return str;
    }
}

#pragma mark - NSMutableString特有的

-(void)miReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString
{
    @try {
        [self miReplaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
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
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
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
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
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
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
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
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
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
        [MiSafeApp showCrashInfoWithException:exception avoidCrashType:MiSafeAvoidCrashType_Ignore];
    }
    @finally {
    }
}

@end
