//
//  MiSafeModel.h
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiSafeCrashInfo:NSObject

/**
 crash的类型。eg： NSRangeException
 */
@property (nonatomic,readonly) NSString *name;

/**
 crash原因。 eg： -[__NSArrayI objectAtIndexedSubscript:]: index 100 beyond bounds [0 .. 2]
 */
@property (nonatomic,readonly) NSString *reason;

/**
 crash的位置。 eg： -[ViewController viewDidLoad]
 */
@property (nonatomic,readonly) NSString *location;

/**
 框架避免崩溃采用的策略
 */
@property (nonatomic,readonly) NSString *avoidCrashDes;

/**
 crash的调用堆栈信息
 */
@property (nonatomic,readonly) NSArray *callSymbolsStack;


/**
 @brief 实例化`MiSafeCrashInfo`(内部使用)

 @param name crash类型
 @param reason crash原因
 @param location crash的位置
 @param avoidCrashDes 框架避免崩溃采用的策略
 @param callSymbolsStack crash的调用堆栈信息
 @return `MiSafeCrashInfo`实例
 */
+ (instancetype)instanceWithName:(NSString *)name
                          reason:(NSString *)reason
                        location:(NSString *)location
                   avoidCrashDes:(NSString *)avoidCrashDes
                callSymbolsStack:(NSArray *)callSymbolsStack;

@end





@interface MiSafeModel : NSObject

@end

NS_ASSUME_NONNULL_END
