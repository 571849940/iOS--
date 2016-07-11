//
//  SelectColorView.m
//  18-画板测试
//
//  Created by shiguanghua on 16/5/11.
//  Copyright © 2016年 shiguanghua. All rights reserved.
//

#import "SelectColorView.h"

@interface SelectColorView ()
{
    SelectColorBlock _selectColorBlock;
}
@end

@implementation SelectColorView


-(void)selectChangeItem:(UIButton *)sender
{
    _selectColorBlock(self.contentArray[sender.tag-100]);
    
}


-(void)afterSelected:(SelectColorBlock)selectBlock
{
    _selectColorBlock = selectBlock;
}







@end
