//
//  HtmlCalledOCController.m
//  05-11-Html5和iOS的交互
//
//  Created by 杨林贵 on 17/5/11.
//  Copyright © 2017年 杨林贵. All rights reserved.
//

#import "HtmlCalledOCController.h"
@interface HtmlCalledOCController ()<UIWebViewDelegate,YLGExport>
@property(nonatomic,strong)JSContext *context;
@end

@implementation HtmlCalledOCController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"HtmlCalledOC";

     //情景：H5界面输入一个值后，传递给OC端，调用OC的方法计算出结果，再传递给H5去显示。
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index1.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    
    UIWebView *webV = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webV.delegate =self;
    [webV loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webV];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //获取html中的内容
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //<!--通过native关联代理协议-->
    self.context[@"native"] = self;
    
    
    //也可以通过block的形式接收从h5传递过来的参数
    self.context[@"test1"] = ^(NSString *pragram){
        NSLog(@"%@",pragram);
    };
    
    //多个参数
    self.context[@"testAction2"] = ^(NSString *pragram1,NSString *pragram2){
        NSLog(@"%@--%@",pragram1,pragram2);
    };
}
-(void)callOcAction:(int)pragram
{
    int result = 0;
    if (pragram<0) {
        result = 0;
    }else{
        result = pragram *pragram;
    }
    
    //在OC端计算出的值再调用html中的方法去显示
   [self.context[@"showRerult"] callWithArguments:@[[NSNumber numberWithInt:result]]];
    NSLog(@"输入值为：%d  计算值为：%d",pragram,result);
    
}

@end
