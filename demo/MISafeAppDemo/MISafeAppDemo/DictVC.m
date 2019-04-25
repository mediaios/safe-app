//
//  DictVC.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/25.
//  Copyright © 2019 iosmedia. All rights reserved.
//

#import "DictVC.h"

@interface DictVC ()

@end

@implementation DictVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)testDict:(id)sender {
    NSString *ab  = nil;
    NSDictionary *dict0 = [NSDictionary dictionaryWithObjectsAndKeys:@"value1",@"ke1",@"value2",@"key2", nil];
    [dict0 objectForKey:ab];
    
    NSDictionary *dict1 = @{@"key1":@"value1",@"key2":@"value2",@"key3":ab};
    NSLog(@"初始化NSDictionary----dict1: %@",dict1);
    
    NSArray *array = @[@"a",@"b"];
    NSArray *key = @[@"key1",@"key2",@"key3",@"key4"];
    NSMutableDictionary *mutaDict1 = [[NSMutableDictionary alloc] initWithObjects:array forKeys:key];
    NSLog(@"mutaDict1: %@",mutaDict1);
    
    [mutaDict1 setObject:nil forKey:@"key3"];
    NSLog(@"mutaDict1: %@",mutaDict1);
    [mutaDict1 removeObjectForKey:ab];
    NSLog(@"取mutaDict1的第五个元素：%@",mutaDict1);
    
    NSString *b = nil;
    static const NSInteger N_ENTRIES = 26;
    NSDictionary *asciiDict;
    NSString *keyArray[N_ENTRIES];
    NSNumber *valueArray[N_ENTRIES];
    NSInteger i;
    for (i = 0; i < N_ENTRIES; i++) {
        char charValue = 'a' + i;
        keyArray[i] = b;
        valueArray[i] = [NSNumber numberWithChar:charValue];
    }
    asciiDict = [NSDictionary dictionaryWithObjects:(id *)valueArray
                                            forKeys:(id *)keyArray
                                              count:N_ENTRIES];
    
    
    NSArray *a=[NSArray arrayWithObjects:@"",@"s", nil];
//    NSLog(@"%@",[[objc_getClass("__NSDictionaryI") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSSingleEntryDictionaryI") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSDictionary0") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSFrozenDictionaryM") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSDictionaryM") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSCFDictionary") class] superclass]);
//    NSLog(@"%@",[[objc_getClass("__NSPlaceholderDictionary") class] superclass]);
    
    NSString *value=nil;
    NSString *strings[3];
    strings[0]=@"000";
    strings[1]=value;
    strings[2]=@"222";
    [[NSDictionary alloc]initWithObjects:strings forKeys:strings count:3];
    [[NSDictionary alloc]initWithObjects:@[@"key1",value,@"key3"] forKeys:@[@"value1",value,@"value3"]];
    NSDictionary *dic1=@{};
    dic1[value];
    
    NSDictionary *dic2=@{@"key1":@"vlaue1"};
    dic2[value];
    
    NSDictionary *dic3=@{@"key1":@"vlaue1",@"key2":@"value2"};
    dic3[value];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"theValue" forKey:@"@theKey"];// 注意这个 key 是以 @ 开头
    NSString *value1 = [dict objectForKey:ab];
    NSString *value2 = [dict valueForKey:ab];
}


- (IBAction)testMutableDict:(id)sender {
    NSString *value=nil;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params setObject:@"fse" forKey:value];
    
    //  dict是  __NSFrozenDictionaryM
        NSMutableDictionary *dict=[[NSMutableDictionary dictionary] copy];
        [dict setObject:@"fsd" forKey:@"FSD"];
        [dict setObject:@"fsd" forKey:value];
        dict[value]=@"fs";
    
    
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
