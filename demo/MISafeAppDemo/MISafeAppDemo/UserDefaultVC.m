//
//  UserDefaultVC.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/28.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "UserDefaultVC.h"

#define MiUserDefaults [NSUserDefaults standardUserDefaults]

@interface UserDefaultVC ()
@property (nonatomic,strong) NSCache *cache;
@end

@implementation UserDefaultVC

- (NSCache *)cache
{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.totalCostLimit = 5;
    }
    return _cache;
}

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

- (IBAction)testCache:(id)sender {
    NSString *key1 = nil;
    [self.cache setObject:key1 forKey:key1];
    [self.cache setObject:@"1111" forKey:key1 cost:10];
}


- (void)testNSSet
{
    NSString *key1 = nil;
//    NSSet *set1 = [[NSSet alloc] initWithObjects:@"1",key1, nil];
//    NSSet *set2 = [NSSet setWithObjects:key1, nil];
    
    // NSSet
    [NSSet setWithObject:nil];   // crash
    
    NSSet *set1 = [[NSSet alloc] initWithObjects:key1,@"11", nil];
    
    [NSSet setWithObject:key1];   // crash
    NSSet *set2 = [NSSet setWithObjects:key1,@"1111",nil];
    //
    NSMutableSet *mutaSet1 = [NSMutableSet set];
    [mutaSet1 addObject:key1];   // crash
    [mutaSet1 removeObject:key1];
}

- (void)testOrderSet
{
    NSString *key1 = nil;
//    NSOrderedSet *orderSet1 = [NSOrderedSet orderedSetWithObjects:key1,@"111", nil];
    
    NSOrderedSet *orderSet2 = [NSOrderedSet orderedSet];
    orderSet2[500]; //crash:  < __NSOrderedSetI>
    [[NSOrderedSet alloc] initWithObject:key1]; // crash: __NSPlaceholderOrderedSet
    NSOrderedSet *orderset3 = nil;
    [NSOrderedSet orderedSetWithSet:orderset3];
}

- (void)testMutableOrderSet
{
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSet];
    set[100];     // crash
    [set addObject:nil];     // crash
    [set insertObject:[NSObject new] atIndex:100];  // crash
    
    [set removeObjectAtIndex:10];   // crash
    
    [set replaceObjectAtIndex:100 withObject:[NSObject new]];   // crash
    
    [[NSMutableOrderedSet alloc]initWithObject:nil];
    
    [NSMutableOrderedSet orderedSetWithSet:nil];
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
