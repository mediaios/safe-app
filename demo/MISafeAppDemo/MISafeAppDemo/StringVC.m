//
//  StringVC.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/24.
//  Copyright © 2019 iosmedia. All rights reserved.
//

#import "StringVC.h"

@interface StringVC ()

@end

@implementation StringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str = @"hello";
    id array1 = [NSArray alloc];
    id array2 = [NSArray alloc];
    
    id array3 = [[NSArray alloc] init];
    
    NSArray *placeholder  = [NSArray alloc];
    NSArray *array4 = [placeholder init];
    
    NSArray *array5 = [placeholder initWithObjects:@0, nil];
    NSLog(@"array5: %s",object_getClassName(array5));
    
    NSArray *array6 = [placeholder initWithObjects:@0,@2, nil];
    NSLog(@"array6: %s",object_getClassName(array5));
    
    
    NSMutableArray *mutaArray1 = [NSMutableArray alloc];
    NSLog(@"mutaArray1: %s",object_getClassName(mutaArray1));
    NSMutableArray *muta2 = [[NSMutableArray alloc] init];
    NSLog(@"muta2: %s",object_getClassName(muta2));
    NSMutableArray *muta3 = [[NSMutableArray alloc] initWithObjects:@1, nil];
    NSLog(@"muta3: %s",object_getClassName(muta3));
    NSMutableArray *muta4 = [NSMutableArray array];
    NSLog(@"muta4: %s",object_getClassName(muta4));
    self.view.backgroundColor = [UIColor redColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"test");
    });
    
    
    
}

- (IBAction)testNSString:(id)sender {
    NSString *str = @"hello";
    [str substringFromIndex:1000];

    NSString *str_1 = [NSString stringWithFormat:@"1234567890"]; // __NSCFString
    [str_1 substringFromIndex:1000];
    
    NSString *str_2 = [NSString stringWithFormat:@"123"];
    [str_2 substringFromIndex:1000];
    
//    return;
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

- (IBAction)testNSMutableString:(id)sender {
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
    NSLog(@"NSMutableString特有crash");
    [s1 replaceCharactersInRange:NSMakeRange(0, 100) withString:@""];
    [s1 replaceOccurrencesOfString:@"" withString:@"" options:0 range:NSMakeRange(0, 100)];
    [s1 insertString:value atIndex:100];
    [s1 deleteCharactersInRange:NSMakeRange(0,100)];
    [s1 appendString:value];
    [s1 setString:value];
    
}
- (IBAction)testNSAttributeString:(id)sender {
    
//    UIFont *font=[UIFont systemFontOfSize:12];
//    [[NSAttributedString alloc]initWithString:nil];
//    [[NSAttributedString alloc]initWithAttributedString:nil];
//    [[NSAttributedString alloc]initWithString:nil attributes:@{NSFontAttributeName:font}];
    
    
    UIFont *font=nil;
    [[NSMutableAttributedString alloc]initWithString:nil];
    NSMutableAttributedString *s1 =  [[NSMutableAttributedString alloc]initWithAttributedString:nil];
    [[NSMutableAttributedString alloc]initWithString:nil attributes:@{NSFontAttributeName:font}];
    NSMutableAttributedString *s2=[[NSMutableAttributedString alloc]initWithString:@"hello world"];
    [s2 replaceCharactersInRange:NSMakeRange(0, 100) withString:@"jj"];
    [s2 setAttributes:nil range:NSMakeRange(0, 100)];
    [s2 addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, 1)];
    [s2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 100)];
    [s2 removeAttribute:NSFontAttributeName range:NSMakeRange(0, 100)];
    [s2 replaceCharactersInRange:NSMakeRange(0, 10) withAttributedString:nil];
    [s2 insertAttributedString:[[NSAttributedString  alloc]initWithString:@"fs"] atIndex:100];
    [s2 appendAttributedString:nil];
    [s2 deleteCharactersInRange:NSMakeRange(0, 100)];
    [s2 setAttributedString:nil];
}

@end
