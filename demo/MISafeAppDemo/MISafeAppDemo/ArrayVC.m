//
//  ArrayVC.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/25.
//  Copyright © 2019 iosmedia. All rights reserved.
//

#import "ArrayVC.h"

@interface ArrayVC ()

@end

@implementation ArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)testNSArray:(id)sender {
    NSArray *arrT = [NSArray alloc];
    NSRange range = NSMakeRange(0, 11);
    __unsafe_unretained id cArray[range.length];
    [arrT getObjects:cArray range:NSMakeRange(0, 20)];
    
    NSString *a = nil;
    NSArray *array1 = nil;
    NSArray *array2 = [[NSArray alloc] initWithArray:array1];
    array2[1000];
    NSLog(@"array2: %@",array2);
    
    array2 = [[NSArray alloc] initWithObjects:@0,nil];
    NSLog(@"array2取元素: %@",array2[1000]);
    
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
    
    //    NSRange range = NSMakeRange(0, 11);
    //    __unsafe_unretained id cArray[range.length];
    //    [array7 getObjects:cArray range:NSMakeRange(0, 20)];
}

- (IBAction)testNSMutableArray:(id)sender {
    NSString *a = nil;
    NSMutableArray *mutaT = [NSMutableArray arrayWithArray:@[@"1",@"2",a]];
    NSRange range = NSMakeRange(0, 11);
    __unsafe_unretained id cArray[range.length];
    [mutaT getObjects:cArray range:NSMakeRange(0, 20)];
    
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
    [mutaArray1 setObject:@1 atIndexedSubscript:1];
    
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


@end
