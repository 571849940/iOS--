//
//  ToolView.h
//  18-画板测试
//
//  Created by shiguanghua on 16/5/11.
//  Copyright © 2016年 shiguanghua. All rights reserved.
//

#import "BaseView.h"
#import "SelectColorView.h"
#import "SelectLineWidthView.h"

typedef void(^ToolActionBlock)(void);

@interface ToolView : BaseView

-(void)afterSelectColor:(SelectColorBlock)selectColorBlock afterSelectLineWidth:(SelectLineWidthBlock)selectLineWidth;


-(void)clickEraserBlock:(ToolActionBlock)eraserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock;



@end
