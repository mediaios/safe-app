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
    [self test_NSDictionary];
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

- (void)test_array
{
//    NSLog(@"%s",__func__);
    NSString *a = nil;
//    NSArray *array = @[@"a1",a];
//    NSLog(@"app: %@",array);
    

    
    NSArray *array1 = nil;
    NSArray *array2 = [[NSArray alloc] initWithArray:array1];
    NSLog(@"array2: %@",array2);

    array2 = [[NSArray alloc] initWithObjects:@"a",a];
    NSLog(@"array2: %@",array2);

    NSArray *array3 = [NSArray arrayWithArray:array1];
    NSLog(@"array3: %@",array3);

    NSArray *array4 = [NSArray arrayWithObjects:@"a",a, nil];
    NSLog(@"array=4: %@",array4);

    NSString *str[3];
    str[0] = @"F";
    str[1] = @"S";
    str[2] = a;
    NSArray *array5 = [NSArray arrayWithObjects:str count:3];
    NSLog(@"array=5: %@",array5);
    
    NSString *ele_5 = array5[10000];
    NSLog(@"ele_5: %@",ele_5);

    NSArray *array6 = [NSArray arrayWithObject:a];
    NSLog(@"array6: %@",array6);

    NSArray *array7 = [[NSArray alloc] initWithArray:array1 copyItems:YES];
    NSLog(@"array7: %@",array7);
    
    
    [self test_mutableArray];
}

- (void)test_mutableArray
{
    NSString *a = nil;
    
    NSMutableArray *mutaArray1 = [[NSMutableArray alloc] init];
    [mutaArray1 addObject:a];
    NSLog(@"添加空元素，mutaArray1: %@",mutaArray1);
    
    NSMutableArray *muta = nil;
    [mutaArray1 addObjectsFromArray:muta];
    NSLog(@"添加空数组, mutaArray1: %@",mutaArray1);
    
    // 插入
    [mutaArray1 insertObject:a atIndex:0];
    NSLog(@"插nil元素后 mutaArray1: %@",mutaArray1);
    
    // 插入
    [mutaArray1 insertObject:@"a" atIndex:20];
    NSLog(@"插入合法元素，index非法时 mutaArray1: %@",mutaArray1);
    
    // 删除
    [mutaArray1 removeObjectAtIndex:20];
    NSLog(@"删除元素： mutaArray1: %@",mutaArray1);
    
    [mutaArray1 addObjectsFromArray:@[@1,@2,@3]];
    [mutaArray1 removeObject:a inRange:NSMakeRange(10, 2)];
    NSLog(@"删除range元素: mutaArray1: %@",mutaArray1);
    
    [mutaArray1 removeObject:@"5"];
    NSLog(@"删除元素-removeObject--mutaArray1: %@",mutaArray1);
    
    
    [mutaArray1 removeObjectsInArray:muta];
    NSLog(@"删除元素--removeObjectsInArray:-----mutaArray1: %@",mutaArray1);
    
    [mutaArray1 removeObjectsInRange:NSMakeRange(10, 20)];
    NSLog(@"删除元素--removeObjectsInRange:-----mutaArray1: %@",mutaArray1);
    
    [mutaArray1 removeObjectIdenticalTo:a];
    NSLog(@"删除元素-removeObjectIdenticalTo:---mutaArray1: %@",mutaArray1);
    
    [mutaArray1 removeObjectIdenticalTo:@2 inRange:NSMakeRange(0, 20)];
    NSLog(@"删除元素-removeObjectIdenticalTo:inRange:---mutaArray1: %@",mutaArray1);
    
    [mutaArray1 replaceObjectAtIndex:20 withObject:@"a"];
    NSLog(@"下表非法，替换元素： mutaArray1: %@",mutaArray1);
    
    [mutaArray1 replaceObjectsInRange:NSMakeRange(0, 10) withObjectsFromArray:muta];
    NSLog(@"替换元素--replaceObjectsInRange: withObjectsFromArray:---mutaArray1: %@",mutaArray1);
    
    NSArray *muta2 = @[@"5",@"6",@"7"];
    [mutaArray1 replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:muta range:NSMakeRange(0, 3)];
    NSLog(@"替换元素--replaceObjectsInRange: withObjectsFromArray:range:---mutaArray1: %@",mutaArray1);
    
    // set array
    [mutaArray1 setArray:muta];
    NSLog(@"添加元素--setArray:--mutaArray1: %@",mutaArray1);
    
    
    
    [mutaArray1 addObject:@"a"];
    [mutaArray1 replaceObjectAtIndex:0 withObject:a];
    NSLog(@"元素为空，替换元素： mutaArray1: %@",mutaArray1);
    
    [mutaArray1 exchangeObjectAtIndex:20 withObjectAtIndex:21];
    NSLog(@"交换元素后： %@",mutaArray1);
    
    
    [self test_array_insert];
    
}

- (void)test_array_insert
{
    /*** 构造数组 ***/
    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
    [mutaArray addObject:@"0"];
    NSString *a  = nil;
    [mutaArray insertObject:a atIndex:1];
    NSLog(@"mutaArray: %@",mutaArray);
    [self test_array_get_element];
}

// test array crash
- (void)test_array_get_element
{
    NSArray *arr = @[@"a",@"b",@"c",@"d",@"e",@"f"];
    NSLog(@"atIndex方式： %@",[arr objectAtIndex:10]);
    NSLog(@"下标方式: %@",arr[10]);
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
