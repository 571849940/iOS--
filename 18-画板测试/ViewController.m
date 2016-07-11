//
//  ViewController.m
//  18-画板测试
//
//  Created by shiguanghua on 16/5/11.
//  Copyright © 2016年 shiguanghua. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "ToolView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //用来划线的视图
    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.frame];
    drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawView];
    
    
    //设置工具栏
    NSArray *contentArray = @[@"颜色",@"线宽",@"橡皮",@"撤销",@"清屏",@"相机",@"保存"];
    ToolView *toolView = [[ToolView alloc]initWithFrame:CGRectMake(0, 0, 414, 50)WithArray:contentArray];
    
    [toolView afterSelectColor:^(UIColor *color) {
        //NSLog(@"%@",color);
        drawView.drawColor = color;
    } afterSelectLineWidth:^(CGFloat lineWidth) {
       // NSLog(@"%f",lineWidth);
        drawView.drawLineWidth = lineWidth;
    }];
    
    
    
    [toolView clickEraserBlock:^{
        
        drawView.drawColor = [UIColor whiteColor];
        
    } WithUndoBlock:^{
        
        [drawView undo];
        
    } WithClearBlock:^{
        
        [drawView clear];
        
    } WithSaveBlock:^{
        
        [drawView save];
        
    }];
    
    
    
    toolView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:toolView];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}




@end
