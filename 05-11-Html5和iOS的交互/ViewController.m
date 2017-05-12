//
//  ViewController.m
//  05-11-Html5和iOS的交互
//
//  Created by 杨林贵 on 17/5/11.
//  Copyright © 2017年 杨林贵. All rights reserved.
//

#import "ViewController.h"
#import "HtmlCalledOCController.h"
#import "OCCalledHtmlController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"首页";
}

- (IBAction)HtmlCalledOCAction:(id)sender {
    
    HtmlCalledOCController *vc1 = [[HtmlCalledOCController alloc] init];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (IBAction)OCCalledHtmlAction:(id)sender {
    
    OCCalledHtmlController *vc1 = [[OCCalledHtmlController alloc] init];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
