//
//  WheelButton.m
//  转盘
//
//  Created by ohhh on 2017/6/15.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "WheelButton.h"

@implementation WheelButton

// 寻找最合适的view
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height;
    
    CGFloat x = 0;
    CGFloat y = btnH / 2;
    CGFloat w = btnW;
    CGFloat h = y;
    CGRect rect = CGRectMake(x, y, w, h);
    if (CGRectContainsPoint(rect, point)) {
        return nil;
    }else{
        return [super hitTest:point withEvent:event];
    }
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = 40;
    CGFloat imageH = 46;
    CGFloat imageX = (contentRect.size.width -40)*0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

@end
