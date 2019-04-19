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
    [self test_array_construct];
}

- (void)test_array_construct
{
    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
    NSString *a = nil;
    [mutaArray addObject:a];
    
    NSArray *array = @[@"a1",a];
    NSLog(@"app: %@",array);
    
}

// test array crash
- (void)test_array_get_element
{
    NSArray *arr = @[@"a",@"b",@"c",@"d",@"e",@"f"];
    NSLog(@"atIndex方式： %@",[arr objectAtIndex:10]);
    NSLog(@"下标方式: %@",arr[10]);
}


@end
