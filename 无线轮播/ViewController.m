//
//  ViewController.m
//  无线轮播
//
//  Created by lanou3g on 16/11/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "CarouselViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<CarouselDelegate>
@property(nonatomic, strong)CarouselViewController *carouseVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
_carouseVC = [[CarouselViewController alloc]init];
    _carouseVC.delegate = self;
    _carouseVC.isPageControl = true;
    _carouseVC.isNSTimer = true;
    _carouseVC.view.frame = CGRectMake(0, 100, kScreenWidth, kScreenWidth *9 / 16);
    [self addChildViewController:_carouseVC];
    [self.view addSubview:_carouseVC.view];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
    [_carouseVC.view addGestureRecognizer:tap];
}

-(void)handleTapAction:(UITapGestureRecognizer *)sender {
    NSLog(@"当前点击了第 %ld 张图片",[_carouseVC backCurrentCilkPicture]);
}
- (NSMutableArray *)backDataSourceArray{
    NSArray *array = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg"];
    return [NSMutableArray arrayWithArray:array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
