//
//  ViewController.m
//  ZEPageControlOC
//
//  Created by 胡春源 on 16/5/7.
//  Copyright © 2016年 胡春源. All rights reserved.
//

#import "ViewController.h"
#import "ZERootViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZERootViewController *zeVC = [[ZERootViewController alloc] init];
    zeVC.tagsArr = @[@"title1",@"title2",@"title3",@"title4"];
    [self addChildViewController:zeVC];
    [self.view addSubview:zeVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
