//
//  HtmlCalledOCController.h
//  05-11-Html5和iOS的交互
//
//  Created by 杨林贵 on 17/5/11.
//  Copyright © 2017年 杨林贵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol YLGExport <JSExport>

-(void)callOcAction:(int)pragram;

@end

@interface HtmlCalledOCController : UIViewController

@end
