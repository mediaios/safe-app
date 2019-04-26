//
//  Person.h
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/26.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
@private
    int _age;
}

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,assign,getter=isMaile) BOOL male;
@property (nonatomic,strong) Car *car;

- (void)setAge:(int)age;
@end

NS_ASSUME_NONNULL_END
