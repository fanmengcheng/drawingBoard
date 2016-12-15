//
//  PaintView.h
//  FMC-画板的实现
//
//  Created by 樊梦成 on 16/12/14.
//  Copyright © 2016年 樊梦成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintView : UIView

@property(nonatomic,strong) UIColor *lineColor;

@property(nonatomic,assign) CGFloat lineWidth;

@property(nonatomic,copy) CGFloat (^lineWidthBlock)();
//
@property(nonatomic,assign) BOOL isPainting;
//清屏
- (void)clear;

//返回
- (void)back;

//橡皮
- (void)eraser;

@end
