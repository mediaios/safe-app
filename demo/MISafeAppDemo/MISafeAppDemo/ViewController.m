//
//  ViewController.m
//  MISafeAppDemo
//
//  Created by ethan on 2019/4/19.
//  Copyright © 2019 ucloud. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test];
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

    NSArray *array6 = [NSArray arrayWithObject:a];
    NSLog(@"array6: %@",array6);

    NSArray *array7 = [[NSArray alloc] initWithArray:array1 copyItems:YES];
    NSLog(@"array7: %@",array7);
    
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
    
    
}

- (void)test_array_insert
{
    /*** 构造数组 ***/
    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
    [mutaArray addObject:@"0"];
    NSString *a  = nil;
    [mutaArray insertObject:a atIndex:1];
    NSLog(@"mutaArray: %@",mutaArray);
    
}

// test array crash
- (void)test_array_get_element
{
    NSArray *arr = @[@"a",@"b",@"c",@"d",@"e",@"f"];
    NSLog(@"atIndex方式： %@",[arr objectAtIndex:10]);
    NSLog(@"下标方式: %@",arr[10]);
}

#pragma mark -NSMutableDictionary
- (void)test
{
    NSString *a  = nil;
    NSDictionary *dict1 = @{@"key1":@"value1",@"key2":@"value2",@"key3":a};
    NSLog(@"初始化NSDictionary----dict1: %@",dict1);
    
    NSArray *array = @[@"a",@"b"];
    NSArray *key = @[@"key1",@"key2",@"key3",@"key4"];
    NSMutableDictionary *mutaDict1 = [[NSMutableDictionary alloc] initWithObjects:array forKeys:key];
    NSLog(@"mutaDict1: %@",mutaDict1);
    
    [mutaDict1 setObject:nil forKey:@"key3"];
    NSLog(@"mutaDict1: %@",mutaDict1);
    
    [mutaDict1 removeObjectForKey:a];
    
    NSLog(@"取mutaDict1的第五个元素：%@",mutaDict1);
    
}


@end
