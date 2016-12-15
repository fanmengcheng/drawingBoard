//
//  PaintView.m
//  FMC-画板的实现
//
//  Created by 樊梦成 on 16/12/14.
//  Copyright © 2016年 樊梦成. All rights reserved.
//

#import "PaintView.h"
#import "BezierPath.h"

@interface PaintView ()

@property(nonatomic,strong) NSMutableArray *pathsArray;

@end
@implementation PaintView


- (NSMutableArray *)pathsArray{
    if (_pathsArray == nil) {
        _pathsArray = [NSMutableArray array];
    }
    return _pathsArray;
}

//清屏
- (void)clear{
    [self.pathsArray removeAllObjects];
    [self setNeedsDisplay];
}

//返回
- (void)back{
    [self.pathsArray removeLastObject];
    [self setNeedsDisplay];
}
//橡皮
- (void)eraser{
    self.lineColor = self.backgroundColor;
}

//触摸屏幕的方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.获取触摸对象
    UITouch *touch = touches.anyObject;
    //2.获取手指的位置
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    BezierPath *path = [[BezierPath alloc]init];
    path.lineColor = self.lineColor;
    if (_isPainting) {
        path.lineWidth = self.lineWidthBlock();
    }else{
        path.lineWidth = self.lineWidth;
    }
    [path moveToPoint:touchPoint];
    
    //将手指划过的线添加到数组中去
    [self.pathsArray addObject:path];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *touch = touches.anyObject;
    //获取手指的位置
    CGPoint touchPoint = [touch locationInView:touch.view];
    //让数组中的最后一条路径画线
    [[self.pathsArray lastObject] addLineToPoint:touchPoint];
    //重绘
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect{
    for (int i = 0; i<self.pathsArray.count; i++) {
        BezierPath *path = self.pathsArray[i];
        [path.lineColor set];
        //设置连接处
        [path setLineJoinStyle:kCGLineJoinRound];
        //设置头尾
        [path setLineCapStyle:kCGLineCapRound];
        //开始渲染；
        [path stroke];
    }
    
    
    
}


@end
