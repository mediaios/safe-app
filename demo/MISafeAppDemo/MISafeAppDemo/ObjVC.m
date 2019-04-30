//
//  ObjVC.m
//  MISafeAppDemo
//
//  Created by iosmediadev@gmail.com on 2019/4/30.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "ObjVC.h"

@interface ObjVC ()

@end

@implementation ObjVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)testUnrecognizedSel:(id)sender {
    id str = @"SDFSDF";
    [str open];
}


@end
