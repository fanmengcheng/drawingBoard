//
//  ViewController.m
//  FMC-画板的实现
//
//  Created by 樊梦成 on 16/12/14.
//  Copyright © 2016年 樊梦成. All rights reserved.
//

#import "ViewController.h"
#import "PaintView.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet PaintView *myPaintView;

@property (strong, nonatomic) IBOutlet UIButton *firstBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self buttonClick:self.firstBtn];
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    self.myPaintView.lineColor = sender.backgroundColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
