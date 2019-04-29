//
//  DataVC.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/29.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "DataVC.h"

@interface DataVC ()

@end

@implementation DataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)testNSData:(id)sender {
    NSData *data1 = [NSData data];   // _NSZeroData
    
    
    NSData *data2 = [NSJSONSerialization dataWithJSONObject:[NSMutableDictionary dictionaryWithDictionary:@{@"name":@"john",@"age":@"20"}] options:0 error:nil];  // NSConcreteData
    
    [data2 subdataWithRange:NSMakeRange(0, 10)];
    [data2 rangeOfData:nil options:0 range:NSMakeRange(0, 10)];
    
    
    NSData *data3 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://www.baidu.com/"]]; // _NSInlineData
    [data3 subdataWithRange:NSMakeRange(0, 100000000)];
    [data3 rangeOfData:nil options:0 range:NSMakeRange(0, 100000000000)];
    
    
    NSString *str = @"hello";
    NSData *data4 = [str dataUsingEncoding:NSUTF8StringEncoding];
    [data4 writeToFile:NULL atomically:YES];
    
    NSMutableData *mutaData1 = [NSMutableData data]; // NSConcreteMutableData
    
    [mutaData1 subdataWithRange:NSMakeRange(0, 1000)];
    [mutaData1 rangeOfData:nil options:0 range:NSMakeRange(0, 100000)];
    
    [mutaData1 resetBytesInRange:NSMakeRange(0, 100)];
    
    [mutaData1 replaceBytesInRange:NSMakeRange(0, 100) withBytes:nil];
    [mutaData1 replaceBytesInRange:NSMakeRange(0, 100) withBytes:nil length:100];
    
    

}


@end
