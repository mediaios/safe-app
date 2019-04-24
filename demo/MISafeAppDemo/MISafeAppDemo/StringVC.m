//
//  StringVC.m
//  MISafeAppDemo
//
//  Created by ethan on 2019/4/24.
//  Copyright © 2019 ucloud. All rights reserved.
//

#import "StringVC.h"

@interface StringVC ()

@end

@implementation StringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)testNSString:(id)sender {
//    NSString *str = @"hello";
//    [str substringFromIndex:1000];

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
