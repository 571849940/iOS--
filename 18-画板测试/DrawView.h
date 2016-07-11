//
//  DrawView.h
//  18-画板测试
//
//  Created by shiguanghua on 16/5/11.
//  Copyright © 2016年 shiguanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property(nonatomic,strong)UIColor *drawColor;
@property(nonatomic,assign)CGFloat drawLineWidth;

-(void)undo;
-(void)clear;
-(void)save;

@end
