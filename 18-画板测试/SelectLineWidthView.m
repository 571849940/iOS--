//
//  SelectLineWidthView.m
//  18-画板测试
//
//  Created by shiguanghua on 16/5/11.
//  Copyright © 2016年 shiguanghua. All rights reserved.
//

#import "SelectLineWidthView.h"

@interface SelectLineWidthView ()
{
    SelectLineWidthBlock _selectLineWidthBlock;
}
@end

@implementation SelectLineWidthView

-(void)selectChangeItem:(UIButton *)sender
{
    
    float lineWidth = [self.contentArray[sender.tag-100]floatValue];
    
    _selectLineWidthBlock(lineWidth);
    
}


-(void)afterSelected:(SelectLineWidthBlock)selectBlock
{
    _selectLineWidthBlock = selectBlock;
}

@end
