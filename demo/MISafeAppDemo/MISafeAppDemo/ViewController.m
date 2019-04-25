//
//  ViewController.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   /*** NSDictionary analysis  ***/
//    NSDictionary *dict1 = [NSDictionary alloc];
//    NSDictionary *dict2 = [[NSDictionary alloc] init];
//    NSDictionary *dict3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"value1",@"key1", nil];
//    NSDictionary *dict4 = [NSDictionary dictionary];
//    NSDictionary *dict5  = @{@"key1":@"value1",@"key2":@"value2",@"key3":@"value3"};
////
////    NSMutableDictionary *mdict = [NSMutableDictionary alloc];
////    NSMutableDictionary *mdict1 = [[NSMutableDictionary alloc] init];
////    [mdict1 setObject:@1 forKey:@"key1"];
    
    
    /*** NSString analysis ***/
    NSString *str1 = [NSString alloc];        // NSPlaceholderString
    NSString *str2 = [[NSString alloc] init];  // __NSCFConstantString : 不可变字符串，可节省内存，提高性能
    NSString *str3 = [NSString string];       // __NSCFConstantString
    NSString *str4 = [str3 copy];
    NSString *str5  = @"1234";
    NSString *str6  = [NSString stringWithFormat:@"123456789"];   // NSTaggedPointerString : 数字、英文、符号等的ASCII字符组成字符串，长度小于等于9的时候会自动成为NSTaggedPointerString类型,其专门用来存储小对象
    NSString *str7 = [NSString stringWithFormat:@"1234567890"];   // __NSCFString : NSCFString对象是一种NSString子类，存储在堆上，不属于字符串常量对象。该对象创建之后和其他的Obj对象一样引用计数为1，对其执行retain和release将改变其retainCount。
    NSMutableString *mutaStr1  = [NSMutableString alloc];         // NSPlaceholderMutableString
    NSMutableString *mutaStr2 = [[NSMutableString alloc] init];   // __NSCFString
    
    
    NSLog(@"test");
    return;
    [self test_NSDictionary];
    
}

#pragma mark -NSAttributedString
- (void)test_NSAttributedString
{
    UIFont *font=[UIFont systemFontOfSize:12];
    [[NSAttributedString alloc] initWithString:nil];
    [[NSAttributedString alloc] initWithAttributedString:nil];
    [[NSAttributedString alloc] initWithString:nil attributes:@{NSFontAttributeName:font}];
    
    [[NSMutableAttributedString alloc] initWithString:nil];
    NSMutableAttributedString *s1 =  [[NSMutableAttributedString alloc] initWithAttributedString:nil];
    [[NSMutableAttributedString alloc] initWithString:nil attributes:@{NSFontAttributeName:font}];
    NSMutableAttributedString *s2=[[NSMutableAttributedString alloc] initWithString:@"hello world"];
    [s2 replaceCharactersInRange:NSMakeRange(0, 100) withString:@"jj"];
    [s2 setAttributes:nil range:NSMakeRange(0, 100)];
    [s2 addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, 1)];
    [s2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 100)];
    [s2 removeAttribute:NSFontAttributeName range:NSMakeRange(0, 100)];
    [s2 replaceCharactersInRange:NSMakeRange(0, 10) withAttributedString:nil];
    [s2 insertAttributedString:[[NSAttributedString  alloc] initWithString:@"fs"] atIndex:1000];
    [s2 appendAttributedString:nil];
    [s2 deleteCharactersInRange:NSMakeRange(0, 1000)];
    [s2 setAttributedString:nil];
    
}

#pragma mark -NSMutableDictionary
- (void)test_NSDictionary
{
   
    
    [self testNSMutableDict];
}

- (void)testNSMutableDict
{
    NSString *value=nil;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params setObject:@"fse" forKey:value];
    
    //  dict是  __NSFrozenDictionaryM
//    NSMutableDictionary *dict=[[NSMutableDictionary dictionary] copy];
//    [dict setObject:@"fsd" forKey:@"FSD"];
//    [dict setObject:@"fsd" forKey:value];
//    dict[value]=@"fs";
    
    
    //dict2是  dict2    __NSCFDictionary
    [[NSUserDefaults standardUserDefaults] setObject:[NSMutableDictionary dictionary] forKey:@"name"];
    NSMutableDictionary *dict2=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    dict2[@"FSD"]=@"FSD";
    [dict2 setObject:@"fsd" forKey:value];
    [dict2 removeObjectForKey:value];
    
    NSString *strings[3];
    strings[0]=@"000";
    strings[1]=value;
    strings[2]=@"222";
    [[NSMutableDictionary alloc]initWithObjects:strings forKeys:strings count:3];
    [[NSMutableDictionary alloc]initWithObjects:@[@"key1",value,@"key3"] forKeys:@[@"value1",value,@"value3"]];
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    dic1[value]=@"";
    dic1[@"d"]=value;
}



@end
