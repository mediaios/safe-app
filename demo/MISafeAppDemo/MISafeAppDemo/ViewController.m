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
}


- (void)test_NSString
{
    NSArray *a=@[@"fs",@"s"];
    NSString *s1=@"128943rfsdsfssds";
    NSString *s122=[NSString stringWithFormat:@"fs"];
    //    403938373635343332319
    NSString *s123=[NSString stringWithFormat:@"fedcba"];
    NSString *s1222=[[NSString alloc] initWithString:@"fs"];
    [s123 substringFromIndex:230];
    NSString *value=nil;
    NSString *ss=[[NSString alloc] initWithString:value];
    [s1 substringFromIndex:100];
    [s1 substringToIndex:100];
    [s1 substringWithRange:NSMakeRange(0, 100)];
    [s1 characterAtIndex:100];
    [s1 stringByReplacingOccurrencesOfString:@"" withString:value];
    [s1 stringByReplacingOccurrencesOfString:@"" withString:@"" options:0 range:NSMakeRange(0, 100)];
    [s1 stringByReplacingCharactersInRange:NSMakeRange(0, 100) withString:@"fs"];
    [s1 hasPrefix:value];
    [s1 hasSuffix:value];
}

- (void)test_NSMutableString
{
    NSMutableString *s1=[NSMutableString stringWithString: @"hello world"];
    NSString *value=nil;
    NSString *ss=[[NSMutableString alloc]initWithString:value];
    [s1 substringFromIndex:100];
    [s1 substringToIndex:100];
    [s1 substringWithRange:NSMakeRange(0, 100)];
    [s1 characterAtIndex:100];
    [s1 stringByReplacingOccurrencesOfString:@"" withString:value];
    [s1 stringByReplacingOccurrencesOfString:@"" withString:@"" options:0 range:NSMakeRange(0, 100)];
    [s1 stringByReplacingCharactersInRange:NSMakeRange(0, 100) withString:@"fs"];
    [s1 hasPrefix:value];
    [s1 hasSuffix:value];
    [s1 replaceCharactersInRange:NSMakeRange(0, 100) withString:@""];
    [s1 replaceOccurrencesOfString:@"" withString:@"" options:0 range:NSMakeRange(0, 100)];
    [s1 insertString:value atIndex:100];
    [s1 deleteCharactersInRange:NSMakeRange(0,100)];
    [s1 appendString:value];
    [s1 setString:value];
    
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
//    NSString *a  = nil;
//    NSDictionary *dict1 = @{@"key1":@"value1",@"key2":@"value2",@"key3":a};
//    NSLog(@"初始化NSDictionary----dict1: %@",dict1);
//
//    NSArray *array = @[@"a",@"b"];
//    NSArray *key = @[@"key1",@"key2",@"key3",@"key4"];
//    NSMutableDictionary *mutaDict1 = [[NSMutableDictionary alloc] initWithObjects:array forKeys:key];
//    NSLog(@"mutaDict1: %@",mutaDict1);
//
//    [mutaDict1 setObject:nil forKey:@"key3"];
//    NSLog(@"mutaDict1: %@",mutaDict1);
//
//    [mutaDict1 removeObjectForKey:a];
//
//    NSLog(@"取mutaDict1的第五个元素：%@",mutaDict1);
    
    
//    NSArray *a=[NSArray arrayWithObjects:@"",@"s", nil];
//    NSLog(@"%@",[[objc_getClass("__NSDictionaryI") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSSingleEntryDictionaryI") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSDictionary0") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSFrozenDictionaryM") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSDictionaryM") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSCFDictionary") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSPlaceholderDictionary") class] superclass]);
//
//    NSString *value=nil;
//    NSString *strings[3];
//    strings[0]=@"000";
//    strings[1]=value;
//    strings[2]=@"222";
//    [[NSDictionary alloc]initWithObjects:strings forKeys:strings count:3];
//    [[NSDictionary alloc]initWithObjects:@[@"key1",value,@"key3"] forKeys:@[@"value1",value,@"value3"]];
//    NSDictionary *dic1=@{};
//    dic1[value];
//
//    NSDictionary *dic2=@{@"key1":@"vlaue1"};
//    dic2[value];
//
//    NSDictionary *dic3=@{@"key1":@"vlaue1",@"key2":@"value2"};
//    dic3[value];
}




@end
