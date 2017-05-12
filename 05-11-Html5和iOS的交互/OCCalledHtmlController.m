//
//  OCCalledHtmlController.m
//  05-11-Html5和iOS的交互
//
//  Created by 杨林贵 on 17/5/11.
//  Copyright © 2017年 杨林贵. All rights reserved.
//

#import "OCCalledHtmlController.h"
@interface OCCalledHtmlController ()<UIWebViewDelegate,YLGEXPort2>
@property(nonatomic,strong)UITextField *textF;
@property(nonatomic,strong)JSContext *context;
@property(nonatomic,strong)UIWebView *webV;
@end

@implementation OCCalledHtmlController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //情景1:OC端传递一个值给JS中的方法，JS中计算出结果后传递回OC端显示。
    //情景2: OC传递一个值给Html，然后调用Html的方法计算出结果，在传递回来一个值给OC。
    self.title = @"OCCalledHtml";
    
    self.view.backgroundColor = [UIColor whiteColor];
  //  [self test1];
    [self test2];
}

-(void)test1{
    UITextField *textFlied = [[UITextField alloc] initWithFrame:CGRectMake(50, 60, 180, 50)];
    textFlied.placeholder = @"请输入数字";
    textFlied.keyboardType = UIKeyboardTypeNumberPad;
    textFlied.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textFlied];
    self.textF = textFlied;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 150, 50)];
    [btn setTitle:@"调用html方法计算" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test.js" ofType:nil];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:content];
    
}

-(void)btnAction:(UIButton *)btn
{
    JSValue *value = [self.context[@"ocCalledHtml"] callWithArguments:@[self.textF.text]];
    
    NSNumber *result =  [value toNumber];
    NSLog(@"输入值为：%@  计算的结果为：%@",self.textF.text,result);
    
}


////////------------ 华丽的分割线---------------//////////
////////------------ 华丽的分割线---------------//////////


-(void)test2
{
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index2.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    webV.delegate =self;
    [webV loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webV];
    
    
    UITextField *textFlied = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, 180, 50)];
    textFlied.placeholder = @"请先输入数字";
    textFlied.keyboardType = UIKeyboardTypeNumberPad;
    textFlied.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textFlied];
    self.textF = textFlied;

}
#pragma YLGExport2 -delegate
-(void)calledOcAction2
{
    if (self.textF.text.length == 0) {
        return;
    }
    NSNumber *number = [NSNumber numberWithInteger:[self.textF.text integerValue]];
    JSValue *value = [self.context[@"getOcPargram"] callWithArguments:@[number]];
    NSNumber *result = [value toNumber];
    NSLog(@"调用Html方法后计算的结果为：%@",result);
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //获取html中的内容
     self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //<!--通过native关联代理协议-->
     self.context[@"native"] = self;
    
    //这里通知通过Html中的方法名传参调用
     JSValue *value = [self.context evaluateScript:@"test1('12');"];
     NSNumber *number = [value toNumber];
     NSLog(@"%@",number);
}

@end
