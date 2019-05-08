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
#import "PersonObserver.h"

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


- (IBAction)testKVO:(id)sender {
    PersonObserver *observer = [[PersonObserver alloc] init];
    Person *p1 = [[Person alloc] init];
    // KVO 正常操作
//    [p1 addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)([Person class]) ];
//    [p1 setAge:10];
//    [p1 removeObserver:observer forKeyPath:@"age"];
    
    /******************** 1.观察者添加错误(观察者没有实现 observeValueForKeyPath:ofObject:change:context: 方法)--->crash  ********************/
    [p1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)([Person class]) ];
    [p1 setAge:10];
    
     /******************** 2.观察者添加错误(forKeyPath为nil)--->crash  ********************/
    NSString *key = nil;
    [p1 addObserver:observer forKeyPath:key options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)([Person class]) ];
    [p1 setAge:10];
    
    /******************** 3.重复移除观察者--->crash  ********************/
    [p1 addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)([Person class]) ];
    [p1 setAge:10];
    [p1 removeObserver:observer forKeyPath:@"age"];
    [p1 removeObserver:observer forKeyPath:@"age"];
    
    /******************** 4.移除观察者时keypath为nil --->crash  ********************/
    [p1 addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)([Person class]) ];
    [p1 setAge:10];
    [p1 removeObserver:observer forKeyPath:nil];
    
    /******************** 5.移除观察者时observer为nil --->crash  ********************/
    [p1 addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)([Person class]) ];
    [p1 setAge:10];
    [p1 removeObserver:nil forKeyPath:@"age"];

    /******************** 6.移除监听了一个不存在的观察者--->crash  ********************/
    [p1 removeObserver:self forKeyPath:@"age"];
    
}





@end
