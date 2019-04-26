//
//  Person.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/26.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "Person.h"


@interface Person()

@end

@implementation Person
- (NSString *)description
{
    return [NSString stringWithFormat:@"Person: name=%@, age=%d , male=%d, car: %@",self.name,self->_age,self.male,self.car];
}
@end
