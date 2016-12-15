//
//  ViewController.m
//  FMC-画板的实现
//
//  Created by 樊梦成 on 16/12/14.
//  Copyright © 2016年 樊梦成. All rights reserved.
//

#import "ViewController.h"
#import "PaintView.h"
@interface ViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet PaintView *myPaintView;
@property (strong, nonatomic) IBOutlet UIButton *firstBtn;
@property (strong, nonatomic) IBOutlet UISlider *mySlider;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *eraserWidth;
@property(strong,nonatomic)  UITextField *textF;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self buttonClick:self.firstBtn];
    self.mySlider.value = 5;
    self.mySlider.minimumValue = 5;
    self.mySlider.maximumValue = 20;
    typeof(self)weakSelf = self;
    self.myPaintView.lineWidthBlock = ^CGFloat{
        return  weakSelf.mySlider.value;
    };
    
    
    //输入橡皮的宽度框
    self.textF = self.eraserWidth.customView;
    self.textF.delegate = self;
    self.textF.placeholder = @"10";
    self.myPaintView.lineWidth = 10;
    [self.textF setFont:[UIFont systemFontOfSize:16.0]];
  //  [self.textF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.textF setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
}

- (IBAction)buttonClick:(UIButton *)sender {
    self.myPaintView.isPainting = YES;
    self.myPaintView.lineColor = sender.backgroundColor;
}

- (IBAction)clearItem:(UIBarButtonItem *)sender {
    [self.myPaintView clear];
}

- (IBAction)backItem:(UIBarButtonItem *)sender {
    [self.myPaintView back];
}

- (IBAction)eraserItem:(UIBarButtonItem *)sender {
    self.myPaintView.isPainting = NO;
    [self.myPaintView eraser];
}


- (IBAction)saveItem:(UIBarButtonItem *)sender {
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.myPaintView.bounds.size, NO , 0);
    //获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //截图
    [self.myPaintView.layer renderInContext:context];
    //取到相片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //存储到相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    //关闭图片上下文
    UIGraphicsEndImageContext();
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSMutableString *text = [NSMutableString stringWithString:textField.text];
    [text replaceCharactersInRange:range withString:string];
    
    self.myPaintView.lineWidth = [text floatValue];

    //判断当输入长度为0的时候让按钮有效返回YES。
    if (text.length == 0) {
        return YES;
    }
    
    if (text.length >= 3) {
        return NO;
    }
    //限制输入数字
    NSCharacterSet *set;
    set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789\n"] invertedSet];
    NSString *filterStr = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filterStr];
    return canChange;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
