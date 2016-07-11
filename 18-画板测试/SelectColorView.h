//
//  SelectColorView.h
//  18-画板测试
//
//  Created by shiguanghua on 16/5/11.
//  Copyright © 2016年 shiguanghua. All rights reserved.
//

#import "BaseView.h"

typedef void(^SelectColorBlock)(UIColor *color);

@interface SelectColorView : BaseView

-(void)afterSelected:(SelectColorBlock)selectBlock;

@end
