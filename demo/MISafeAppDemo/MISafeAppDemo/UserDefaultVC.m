//
//  UserDefaultVC.m
//  MISafeAppDemo
//
//  Created by ethan on 2019/4/28.
//  Copyright © 2019 ucloud. All rights reserved.
//

#import "UserDefaultVC.h"

#define MiUserDefaults [NSUserDefaults standardUserDefaults]

@interface UserDefaultVC ()

@end

@implementation UserDefaultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)testUserDefaults:(id)sender {
    NSString *key1 = nil;
    [MiUserDefaults setObject:@"22" forKey:key1];
    [MiUserDefaults objectForKey:key1];
    [MiUserDefaults removeObjectForKey:key1];
    [MiUserDefaults stringForKey:key1];
    [MiUserDefaults arrayForKey:key1];
    [MiUserDefaults dataForKey:key1];
    [MiUserDefaults stringArrayForKey:key1];
    [MiUserDefaults integerForKey:key1];
    [MiUserDefaults floatForKey:key1];
    [MiUserDefaults doubleForKey:key1];
    [MiUserDefaults boolForKey:key1];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
