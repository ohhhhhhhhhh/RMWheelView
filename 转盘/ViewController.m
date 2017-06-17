//
//  ViewController.m
//  转盘
//
//  Created by ohhh on 2017/6/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "ViewController.h"
#import "WheelView.h"

@interface ViewController ()

@property (nonatomic,  weak) WheelView * wheelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    WheelView * wheelView = [WheelView wheelView];
    
    wheelView.center = self.view.center;
    
    _wheelView = wheelView;
    
    [self.view addSubview:wheelView];
}

- (IBAction)start:(UIButton *)sender {
    
    [_wheelView start];
}


- (IBAction)pause:(UIButton *)sender {
    
    [_wheelView pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
