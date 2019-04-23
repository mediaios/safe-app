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
@implementation NSMutableString (MiSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class strClass = NSClassFromString(@"__NSCFString");
        Class placeholderStrClass = NSClassFromString(@"NSPlaceholderMutableString");
        
        [NSObject miSwizzleInstanceMethod:placeholderStrClass
                                 swizzSel:@selector(initWithString:)
                            toSwizzledSel:@selector(miInitWithString:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(hasPrefix:)
                            toSwizzledSel:@selector(miHasPrefix:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(hasSuffix:)
                            toSwizzledSel:@selector(miHasSuffix:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(substringFromIndex:)
                            toSwizzledSel:@selector(miSubstringFromIndex:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(substringToIndex:)
                            toSwizzledSel:@selector(miSubstringToIndex:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(substringWithRange:)
                            toSwizzledSel:@selector(miSubstringWithRange:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(characterAtIndex:)
                            toSwizzledSel:@selector(miCharacterAtIndex:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                            toSwizzledSel:@selector(miStringByReplacingOccurrencesOfString:withString:options:range:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(stringByReplacingCharactersInRange:withString:)
                            toSwizzledSel:@selector(miStringByReplacingCharactersInRange:withString:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(replaceCharactersInRange:withString:)
                            toSwizzledSel:@selector(miReplaceCharactersInRange:withString:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(replaceOccurrencesOfString:withString:options:range:)
                            toSwizzledSel:@selector(miReplaceOccurrencesOfString:withString:options:range:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(insertString:atIndex:)
                            toSwizzledSel:@selector(miInsertString:atIndex:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(deleteCharactersInRange:)
                            toSwizzledSel:@selector(miDeleteCharactersInRange:)];
        [NSObject miSwizzleInstanceMethod:strClass
                                 swizzSel:@selector(appendString:)
                            toSwizzledSel:@selector(miAppendString:)];
        [NSObject miSwizzleInstanceMethod:strClass
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
        
    }
    @finally {
        return instance;
    }
}


-(BOOL)miHasPrefix:(NSString *)str
{
    BOOL has = NO;
    @try {
        has = [self miHasPrefix:str];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        return has;
    }
}

-(BOOL)miHasSuffix:(NSString *)str
{
    BOOL has = NO;
    @try {
        has = [self miHasSuffix:str];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        return has;
    }
}

- (NSString *)miSubstringFromIndex:(NSUInteger)from {
    
    NSString *subString = nil;
    @try {
        subString = [self miSubstringFromIndex:from];
    }
    @catch (NSException *exception) {
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (NSString *)miSubstringToIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self miSubstringToIndex:index];
    }
    @catch (NSException *exception) {
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (NSString *)miSubstringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    @try {
        subString = [self miSubstringWithRange:range];
    }
    @catch (NSException *exception) {
       
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (unichar)miCharacterAtIndex:(NSUInteger)index {
    
    unichar characteristic;
    @try {
        characteristic = [self miCharacterAtIndex:index];
    }
    @catch (NSException *exception) {
       
    }
    @finally {
        return characteristic;
    }
}


- (NSString *)miStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self miStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


- (NSString *)miStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self miStringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        
        newStr = nil;
    }
    @finally {
        return newStr;
    }
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
