//
//  CarouselViewController.m
//  无线轮播
//
//  Created by lanou3g on 16/11/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CarouselViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface CarouselViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong)UIImageView *leftImageView, *middleImageView, *rightImageView;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, assign)NSInteger currentIndex;
@property(nonatomic, strong)NSMutableArray *dataSoure;
@property(nonatomic, assign)NSInteger scrollerViewwidth, scrollerViewHeight;
@property(nonatomic, strong)UIPageControl *page;
@property(nonatomic, strong)NSTimer *timer;

@end

@implementation CarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollerViewwidth = kScreenWidth;
    _scrollerViewHeight = self.scrollerViewwidth *0.5625;
    if (_delegate && [_delegate respondsToSelector:@selector(backDataSourceArray)]) {
        if (_delegate && [_delegate respondsToSelector:@selector(backScrillerForWidthAndHeight)]) {
            CGSize size = [_delegate backScrillerForWidthAndHeight];
            self.scrollerViewwidth = size.width;
            self.scrollerViewHeight = size.height;
        }
        self.dataSoure = [NSMutableArray arrayWithArray:[_delegate backDataSourceArray]];
        [self configureScrollerView];
        [self configureImageView];
        if (_isPageControl) {
            [self configurePageController];
        }
        if (_isNSTimer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePic) userInfo:nil repeats:YES];
            
        }
    }
}

-(void)configureScrollerView {
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.scrollerViewwidth, self.scrollerViewHeight)];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.scrollerViewwidth *3, self.scrollerViewHeight);
    _scrollView.contentOffset = CGPointMake(self.scrollerViewwidth, 0);
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
}

-(void)configureImageView {
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.scrollerViewwidth, self.scrollerViewHeight)];
    self.middleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollerViewwidth, 0,self.scrollerViewwidth, self.scrollerViewHeight)];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollerViewwidth *2, 0, self.scrollerViewwidth, self.scrollerViewHeight)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    if (self.dataSoure.count != 0) {
        self.leftImageView.image = [UIImage imageNamed:self.dataSoure.lastObject];
        self.middleImageView.image = [UIImage imageNamed:self.dataSoure.firstObject];
        self.rightImageView.image = [UIImage imageNamed:self.dataSoure[1]];
    }
    [self.scrollView addSubview: self.leftImageView];
    [self.scrollView addSubview: self.middleImageView];
    [self.scrollView addSubview: self.rightImageView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    if (self.dataSoure.count != 0) {
        if (offset >= 2* self.scrollerViewwidth) {
            scrollView.contentOffset = CGPointMake(self.scrollerViewwidth, 0);
            self.currentIndex++;
//            第六张往第七章滚
            if (self.currentIndex == self.dataSoure.count - 1) {
                self.leftImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex - 1]];
                self.middleImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSoure.firstObject];
                self.page.currentPage = self.currentIndex;
            } else if (self.currentIndex == self.dataSoure.count || self.currentIndex == 0) {
                self.leftImageView.image = [UIImage imageNamed:self.dataSoure.lastObject];
                self.middleImageView.image = [UIImage imageNamed:self.dataSoure.firstObject];
                self.rightImageView.image = [UIImage imageNamed:self.dataSoure[1]];
                self.page.currentPage = 0;
                self.currentIndex = 0;
            } else {
                self.leftImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex - 1]];
                self.middleImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex + 1]];
                self.page.currentPage = self.currentIndex;
            }
        }
        if (offset <= 0) {
            scrollView.contentOffset = CGPointMake(self.scrollerViewwidth, 0);
            self.currentIndex --;
            if (self.currentIndex == -2) {
                self.currentIndex = self.dataSoure.count - 2;
                self.leftImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex - 1]];
                self.middleImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSoure.lastObject];
                self.page.currentPage =self.currentIndex;
            } else
                if (self.currentIndex == -1) {
                self.currentIndex = self.dataSoure.count - 1;
                self.leftImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex -1]];
                self.middleImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSoure.firstObject];
                self.page.currentPage = self.currentIndex;
            } else if (self.currentIndex == 0) {
                self.leftImageView.image = [UIImage imageNamed:self.dataSoure.lastObject];
                self.middleImageView.image = [UIImage imageNamed: self.dataSoure.firstObject];
                self.rightImageView.image = [UIImage imageNamed:self.dataSoure[1]];
                self.page.currentPage = self.currentIndex;
            } else {
                self.leftImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex - 1]];
                self.middleImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSoure[self.currentIndex + 1]];
                self.page.currentPage = self.currentIndex;
            }
        }
    }
}

-(void)configurePageController {
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.scrollerViewHeight - 20, self.scrollerViewwidth, 20)];
    self.page.numberOfPages = self.dataSoure.count;
    self.page.currentPageIndicatorTintColor = [UIColor redColor];
    self.page.userInteractionEnabled = NO;
    [self.view addSubview:self.page];
}
-(void)changePic {
    CGFloat offset =+ 2 * kScreenWidth;
    self.scrollView.contentOffset =CGPointMake(offset, 0);
}

-(NSInteger)backCurrentCilkPicture {
    return self.page.currentPage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
