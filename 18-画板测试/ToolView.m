//
//  ToolView.m
//  18-画板测试
//
//  Created by shiguanghua on 16/5/11.
//  Copyright © 2016年 shiguanghua. All rights reserved.
//

#import "ToolView.h"
#import "SelectColorView.h"
#import "SelectLineWidthView.h"
typedef enum : NSUInteger {
    kColorSelect = 100,
    kLineWidthSelect,
    KEraserSelect,
    kUndoSelect,
    kClearScreenSelect,
    kcameraSelect,
    kSaveSelect
} kSelectItem;


@interface ToolView ()
{
    SelectLineWidthBlock _selectLineWidthBlock;
    
    SelectColorBlock _selectColorBlock;
    
    ToolActionBlock _eraserBlock;
    ToolActionBlock _undoBlock;
    ToolActionBlock _clearBlock;
    ToolActionBlock _saveBlock;
}

//颜色选择视图
@property(nonatomic,strong)SelectColorView *selectColorView;
//线宽选择视图
@property(nonatomic,strong)SelectLineWidthView *selectLineWidthView;

@end


@implementation ToolView

-(void)selectChangeItem:(UIButton *)sender
{
    
    switch (sender.tag)
    {
        case kColorSelect:
        {
            [self forceHideView:self.selectColorView];
            
           [self showHideColorSelectView];///////////////111111111////////////////
            
        }break;
            
        case kLineWidthSelect:
        {
            [self forceHideView:self.selectLineWidthView];
            
            [self showHideLineWidthSelectView];//////////////222222222////////////////
            
        }break;
            
        case KEraserSelect:
        {
            _eraserBlock();
            
        }break;
            
        case kUndoSelect:
        {
            _undoBlock();
            
            
        }break;
            
        case kClearScreenSelect:
        {
            
            _clearBlock();
            
        }break;
            
        case kcameraSelect:
        {
            
        }break;
            
        case kSaveSelect:
        {
            _saveBlock();
            
        }break;
        default:
            break;
    }
    
}


//点击颜色按钮，让颜色选择视图显示或隐藏
- (void)showHideColorSelectView//////////////////////111111111//////////////////////
{
    if (self.selectColorView == nil)
    {
        NSArray *contentArray = @[[UIColor redColor],[UIColor blackColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor blueColor],[UIColor greenColor],[UIColor cyanColor]];
        
        self.selectColorView = [[SelectColorView alloc]initWithFrame:CGRectMake(0, -50, 414, 50) WithArray:contentArray];
        
        //block块传进来点击的颜色
        [self.selectColorView afterSelected:^(UIColor *color) {
         //   NSLog(@"%@",color);
            
            _selectColorBlock(color);
            //点击每个按钮后，让颜色视图消失
            [self forceHideView:nil];
        }];
        
        
        self.selectColorView.backgroundColor = [UIColor lightGrayColor];
        //把选择颜色的视图添加到工具视图上面
        [self addSubview:self.selectColorView];
        
    }
    
    [self showHideView:self.selectColorView];
    
}



//让视图动画式的出现和消失
-(void)showHideView:(UIView *)view///////////////////////////////////////////////////
{
    //保存要消失或出现视图的frame
    CGRect toFrame = view.frame;
    //保存当前工具栏的frame
    CGRect toolFrame = self.frame;
    
    if (toFrame.origin.y>0)
    {
        toFrame.origin.y = -50;
        toolFrame.size.height = 50;
    }else
    {
        toFrame.origin.y = 50;
        toolFrame.size.height = 100;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.frame = toFrame;
        self.frame = toolFrame;
        
    }];
  
}




//点击线宽按钮，让线宽视图隐藏或显示
-(void)showHideLineWidthSelectView////////////////////222222222/////////////////////
{
    
    NSArray *contentArray = @[@"2",@"4",@"8",@"10",@"12",@"14",@"16"];
    
    if (self.selectLineWidthView == nil)
    {
        self.selectLineWidthView = [[SelectLineWidthView alloc]initWithFrame:CGRectMake(0, -50, 414, 50) WithArray:contentArray];
        
        //block传线宽
        [self.selectLineWidthView afterSelected:^(CGFloat lineWidth) {
           // NSLog(@"%f",lineWidth);
            
            _selectLineWidthBlock(lineWidth);
            
            [self forceHideView:nil];
        }];
        
        self.selectLineWidthView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.selectLineWidthView];
    }
    
    [self showHideView:self.selectLineWidthView];
    
}




//点击一个按钮时，该按钮的视图没有消失时，又点击另一个按钮时，让第一个按钮的视图隐藏，让点击的按钮视图出现(即强制隐藏视图)
-(void)forceHideView:(UIView *)view////////////////////////////////////////////////
{
    UIView *showView = nil;
    
    if (self.selectColorView.frame.origin.y>0)
    {
        showView = self.selectColorView;
    }else if(self.selectLineWidthView.frame.origin.y>0)
    {
        showView = self.selectLineWidthView;
    }else
    {
        return;
    }
    
    //当视图显示和隐藏点击的是同一个按钮时，结束该方法
    if (view == showView)
    {
        return;
    }
    
    CGRect toFrame = showView.frame;
    CGRect toolFrame = self.frame;
    
    toFrame.origin.y = -50;
    toolFrame.size.height = 50;
    [UIView animateWithDuration:0.5 animations:^{
        
        showView.frame = toFrame;
        self.frame = toolFrame;
        
    }];
    
    
}



//block传值的方法,保留传进来的block
-(void)afterSelectColor:(SelectColorBlock)selectColorBlock afterSelectLineWidth:(SelectLineWidthBlock)selectLineWidth
{
    _selectColorBlock = selectColorBlock;
    
    _selectLineWidthBlock = selectLineWidth;
    
}



-(void)clickEraserBlock:(ToolActionBlock)eraserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock;
{
    _eraserBlock = eraserBlock;
    _undoBlock = undoBlock;
    _clearBlock = clearBlock;
    _saveBlock = saveBlock;
}




















@end
