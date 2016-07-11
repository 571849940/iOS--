//
//  DrawView.m
//  18-画板测试
//
//  Created by shiguanghua on 16/5/11.
//  Copyright © 2016年 shiguanghua. All rights reserved.
//

#import "DrawView.h"
#import "PathModel.h"
@interface DrawView ()

//当前正在绘制的路径
@property(nonatomic,assign)CGMutablePathRef path;

//stronng和retain一样,pathArray存放已经绘制过的路径
@property(nonatomic,strong)NSMutableArray *pathArray;

//判断当前路径是否被释放
@property(nonatomic,assign)BOOL isReleasePath;

@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.drawColor = [UIColor blackColor];
        self.drawLineWidth = 10;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    //1.获取上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawView:context];
 
}


-(void)drawView:(CGContextRef)context
{
    
    
    for (PathModel *pathModel in self.pathArray)
    {
       // CGContextAddPath(context, path.CGPath);
        CGContextAddPath(context, pathModel.bezierPath.CGPath);
        [pathModel.color setStroke];
        CGContextSetLineWidth(context, pathModel.lineWidth);
        
        CGContextDrawPath(context, kCGPathStroke);
    }
    
  
    
//    //2.创建路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    //2.1设置起点
//    CGPathMoveToPoint(path, NULL, 50, 50);
//    //2.2追加路径
//    CGPathAddLineToPoint(self.path, NULL, 50, 100);
    
    if (self.isReleasePath == NO)
    {
        //3.设置上下文状态
      //  [[UIColor redColor] setStroke];
        [self.drawColor setStroke];
        CGContextSetLineWidth(context, self.drawLineWidth);
        
        //4.把路径添加到上下文
        CGContextAddPath(context, self.path);
        
        //5.绘制路径
        CGContextDrawPath(context, kCGPathStroke);

    }
    
    
//    //6.释放路径
//    CGPathRelease(self.path);
    
}


////////////////////设置起点///////////////////
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //通过touchesBegan获取到当前触摸的位置(即起点位置)
    CGPoint point = [[touches anyObject]locationInView:self];
    
    //路径创建时，将isReleasePath设置成NO，表示当前路径没有被释放
    self.isReleasePath = NO;
    
    //2.创建路径
     self.path = CGPathCreateMutable();
    //2.1设置起点
    CGPathMoveToPoint(self.path, NULL, point.x, point.y);
 
}



////////////////////追加路径////////////////////
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取位置
    CGPoint point = [[touches anyObject]locationInView:self];
    
    //2.2追加路径
    CGPathAddLineToPoint(self.path, NULL, point.x, point.y);

    //不能直接调用drawRect方法，通过setNeedsDisplay触发drawRect方法的执行
    [self setNeedsDisplay];
    
    
}


//////////////////////触摸结束的时候释放路径//////////////////////////
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //用数组保存每次的路径
    if (self.pathArray == nil)
    {
        self.pathArray = [NSMutableArray array];
    }
    //使用贝塞尔曲线，将路径包装成对象
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:self.path];
    
    //保存路径和其他信息
    PathModel *pathModel = [[PathModel alloc]init];
    pathModel.bezierPath = bezierPath;
    pathModel.color = self.drawColor;
    pathModel.lineWidth = self.drawLineWidth;
    
    [self.pathArray addObject:pathModel];
    
    //6.释放路径
    CGPathRelease(self.path);
    
    //表明路径被释放了
    self.isReleasePath = YES;

}



-(void)undo
{
    [self.pathArray removeLastObject];
    
    [self setNeedsDisplay];
    
}


-(void)clear
{
    [self.pathArray removeAllObjects];
    
    [self setNeedsDisplay];
}



-(void)save
{
    //指定要保存的图片的大小
    UIGraphicsBeginImageContext(CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))); //currentView 当前的view
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];///////////////////////
    
    //获取到绘制的内容
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图像上下文
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    
}









@end
