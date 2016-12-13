//
//  CarouselViewController.h
//  无线轮播
//
//  Created by lanou3g on 16/11/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselDelegate <NSObject>

@required
- (NSMutableArray *)backDataSourceArray;
@optional
-(CGSize)backScrillerForWidthAndHeight;

@end

@interface CarouselViewController : UIViewController
@property(nonatomic, assign)id<CarouselDelegate>delegate;
@property(nonatomic, assign)BOOL isPageControl;
@property(nonatomic, assign)BOOL isNSTimer;
@property(nonatomic, assign) NSInteger time;

-(NSInteger)backCurrentCilkPicture;

@end
