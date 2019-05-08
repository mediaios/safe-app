//
//  NSData+MiSafe.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/29.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSData+MiSafe.h"
#import "NSObject+MiSafe.h"
#import "MiSafeApp.h"

@implementation NSData (MiSafe)

+ (void)miOpenNSDataMiSafe
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // hook NSData
        Class zeroDataClass = NSClassFromString(@"_NSZeroData");
        [self miSwizzleInstanceMethod:zeroDataClass
                             swizzSel:@selector(subdataWithRange:)
                        toSwizzledSel:@selector(miZeroDataSubdataWithRange:)];
        [self miSwizzleInstanceMethod:zeroDataClass
                             swizzSel:@selector(rangeOfData:options:range:)
                        toSwizzledSel:@selector(miZeroDataRangeOfData:options:range:)];
        
        Class concreteDataClass = NSClassFromString(@"NSConcreteData");
        [self miSwizzleInstanceMethod:concreteDataClass
                             swizzSel:@selector(subdataWithRange:)
                        toSwizzledSel:@selector(miConcreteDataSubdataWithRange:)];
        [self miSwizzleInstanceMethod:concreteDataClass
                             swizzSel:@selector(rangeOfData:options:range:)
                        toSwizzledSel:@selector(miConcreteDataRangeOfData:options:range:)];
        
        Class inLineData = NSClassFromString(@"_NSInlineData");
        [self miSwizzleInstanceMethod:inLineData
                             swizzSel:@selector(subdataWithRange:)
                        toSwizzledSel:@selector(miInlineDataSubdataWithRange:)];
        [self miSwizzleInstanceMethod:inLineData
                             swizzSel:@selector(rangeOfData:options:range:)
                        toSwizzledSel:@selector(miInlineDataRangeOfData:options:range:)];
        
        
        Class cfDataClass = NSClassFromString(@"__NSCFData");
        [self miSwizzleInstanceMethod:cfDataClass
                             swizzSel:@selector(subdataWithRange:)
                        toSwizzledSel:@selector(miCfDataSubdataWithRange:)];
        [self miSwizzleInstanceMethod:cfDataClass
                             swizzSel:@selector(rangeOfData:options:range:)
                        toSwizzledSel:@selector(miCfDataRangeOfData:options:range:)];
        
        // hook NSMutableData
        Class mutaDataClass = NSClassFromString(@"NSConcreteMutableData");
        [self miSwizzleInstanceMethod:mutaDataClass
                             swizzSel:@selector(subdataWithRange:)
                        toSwizzledSel:@selector(miMutaDataSubdataWithRange:)];
        [self miSwizzleInstanceMethod:mutaDataClass
                             swizzSel:@selector(rangeOfData:options:range:)
                        toSwizzledSel:@selector(miMutaDataRangeOfData:options:range:)];
        [self miSwizzleInstanceMethod:mutaDataClass
                             swizzSel:@selector(resetBytesInRange:)
                        toSwizzledSel:@selector(miMutaDataResetBytesInRange:)];
        [self miSwizzleInstanceMethod:mutaDataClass
                             swizzSel:@selector(replaceBytesInRange:withBytes:)
                        toSwizzledSel:@selector(miMutaDataReplaceBytesInRange:withBytes:)];
        [self miSwizzleInstanceMethod:mutaDataClass
                             swizzSel:@selector(replaceBytesInRange:withBytes:length:)
                        toSwizzledSel:@selector(miMutaDataReplaceBytesInRange:withBytes:length:)];
    
    });
}

#pragma mark -NSData
- (NSData *)miZeroDataSubdataWithRange:(NSRange)range
{
    id obj = nil;
    @try {
        obj = [self miZeroDataSubdataWithRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(_NSZeroData)[subdataWithRange:] crash , return nil"];
    } @finally {
        return obj;
    }
}

- (NSRange)miZeroDataRangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange rg;
    @try {
        rg = [self miZeroDataRangeOfData:dataToFind options:mask range:searchRange];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(_NSZeroData)[rangeOfData:options:range:] crash , return (0,0)"];
    } @finally {
        return rg;
    }
}

- (NSData *)miConcreteDataSubdataWithRange:(NSRange)range
{
    id obj = nil;
    @try {
        obj = [self miConcreteDataSubdataWithRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(NSConcreteData)[subdataWithRange:] crash , return nil"];
    } @finally {
        return obj;
    }
}

- (NSRange)miConcreteDataRangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange rg;
    @try {
        rg = [self miConcreteDataRangeOfData:dataToFind options:mask range:searchRange];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(NSConcreteData)[rangeOfData:options:range:] crash , return (0,0)"];
    } @finally {
        return rg;
    }
}

- (NSData *)miInlineDataSubdataWithRange:(NSRange)range
{
    id obj = nil;
    @try {
        obj = [self miInlineDataSubdataWithRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(_NSInlineData)[subdataWithRange:] crash , return nil"];
    } @finally {
        return obj;
    }
}

- (NSRange)miInlineDataRangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange rg;
    @try {
        rg = [self miInlineDataRangeOfData:dataToFind options:mask range:searchRange];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(_NSInlineData)[rangeOfData:options:range:] crash , return (0,0)"];
    } @finally {
        return rg;
    }
}

- (NSData *)miCfDataSubdataWithRange:(NSRange)range
{
    id obj = nil;
    @try {
        obj = [self miCfDataSubdataWithRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(__NSCFData)[subdataWithRange:] crash , return nil"];
    } @finally {
        return obj;
    }
}

- (NSRange)miCfDataRangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange rg;
    @try {
        rg = [self miCfDataRangeOfData:dataToFind options:mask range:searchRange];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(__NSCFData)[rangeOfData:options:range:] crash , return (0,0)"];
    } @finally {
        return rg;
    }
}

#pragma mark -NSMutableData
- (NSData *)miMutaDataSubdataWithRange:(NSRange)range
{
    id obj = nil;
    @try {
        obj = [self miMutaDataSubdataWithRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(NSConcreteMutableData)[subdataWithRange:] crash , return nil"];
    } @finally {
        return obj;
    }
}

- (NSRange)miMutaDataRangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange rg;
    @try {
        rg = [self miMutaDataRangeOfData:dataToFind options:mask range:searchRange];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(NSConcreteMutableData)[rangeOfData:options:range:] crash , return nil"];
    } @finally {
        return rg;
    }
}

- (void)miMutaDataResetBytesInRange:(NSRange)range
{
    @try {
        [self miMutaDataResetBytesInRange:range];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(NSConcreteMutableData)[resetBytesInRange:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miMutaDataReplaceBytesInRange:(NSRange)range withBytes:(const void *)bytes
{
    @try {
        if (bytes) {
            [self miMutaDataReplaceBytesInRange:range withBytes:bytes];
        }else{
            NSException *exception = [NSException exceptionWithName:@"MINSMutaDataException" reason:@"[replaceBytesInRange:withBytes:], key is nil" userInfo:@{@"errorInfo":@"[replaceBytesInRange:withBytes:] error"}];
            [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(NSConcreteMutableData)[replaceBytesInRange:withBytes:] crash , ignore this method operation"];
        }
        
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(NSConcreteMutableData)[replaceBytesInRange:withBytes:] crash , ignore this method operation"];
    } @finally {}
}

- (void)miMutaDataReplaceBytesInRange:(NSRange)range withBytes:(nullable const void *)replacementBytes length:(NSUInteger)replacementLength
{
    @try {
        [self miMutaDataReplaceBytesInRange:range withBytes:replacementBytes length:replacementLength];
    } @catch (NSException *exception) {
        [MiSafeApp showCrashInfoWithException:exception crashType:MiSafeCrashType_NSData crashDes:@"(NSConcreteMutableData)[replaceBytesInRange:withBytes:length:] crash , ignore this method operation"];
    } @finally {}
}


@end
