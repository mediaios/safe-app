//
//  TestKVCViewController.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/26.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "TestKVCViewController.h"
#import "Person.h"
#import "Car.h"
#import "MiSafeApp.h"

@interface TestKVCViewController ()

@end

@implementation TestKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (IBAction)testKVC:(id)sender {
    /*** KVC:设置值 ***/
    NSString *key1 = nil;
    Person *p1 = [[Person alloc] init];
    Car *c1 = [[Car alloc] init];
    p1.car = c1;
    [p1 setValue:@"Bob" forKey:@"name"];
    NSLog(@"%@",p1);
    [p1 setValue:nil forKey:@"name"];
    
    /********** 测试 setValue:forKey: *************/
    [p1 setValue:@"Jim" forKey:key1];   // crash   : NSInvalidArgumentException
    [p1 setValue:@"红色" forKeyPath:@"car.color"];  // success
    
    /********** 测试 setValue:forKeyPath: *************/
    [p1 setValue:@"红色" forKeyPath:@"car.color"];  // success
    [p1 setValue:@"红色" forKeyPath:@"car.color1"];  // crash : NSUnknownKeyException
    
    c1.color = @"黑色";
    NSDictionary *dict = @{@"age":@20,@"name":@"Song",@"male":@NO,@"car":c1};
    [p1 setValuesForKeysWithDictionary:dict];   // success
    
    
    NSDictionary *dict2 = @{@"age":@20,@"name":@"Song",@"male":@NO,@"car1":c1};
    [p1 setValuesForKeysWithDictionary:dict2];    // crash
    NSLog(@"%@",p1);
    
    NSString *name = [p1 valueForKey:@"name"];
    NSLog(@"name:%@",name);
    NSLog(@"%@",p1);
}





@end
