//
//  NotifiVC.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/29.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NotifiVC.h"

@interface MiNotiObserver:NSObject

- (void)obserNoti;
@end

@implementation MiNotiObserver

- (instancetype)init
{
    self = [super init];
    if (self) {
       NSLog(@"notiObserver 创建了...");
    }
    return self;
}

- (void)obserNoti
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"testNoti" object:nil];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(testTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)testTimer
{
    NSLog(@"%s", __func__);
}

- (void)tongzhi
{
    NSLog(@"receive a notification...");
}

- (void)dealloc
{
    NSLog(@"notiObserver 销毁了...");
}

@end



@interface NotifiVC ()
@property (nonatomic,strong) MiNotiObserver *notiObserver;
@end

@implementation NotifiVC

//- (MiNotiObserver *)notiObserver
//{
//    if (!_notiObserver) {
//        _notiObserver = [[MiNotiObserver alloc] init];
//    }
//    return _notiObserver;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[self notiObserver] obserNoti];
    _notiObserver = [[MiNotiObserver alloc] init];
    [_notiObserver obserNoti];
    

}

- (IBAction)sendNoti:(id)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"testNoti" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _notiObserver = nil;
}

- (IBAction)testCrash:(id)sender {
    // 1.移除通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self.notiObserver];
    
    // 2.发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNoti" object:self.notiObserver];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNoti" object:self.notiObserver userInfo:nil];
}




@end
