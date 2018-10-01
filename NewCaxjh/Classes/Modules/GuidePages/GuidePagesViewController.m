//
//  GuidePagesViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "GuidePagesViewController.h"
#import "BaseTabBarViewController.h"

@interface GuidePagesViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic,weak)UIPageControl *pageControl;
@property (nonatomic ,strong)NSArray *imagesList;
@end

@implementation GuidePagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.imagesList = [NSArray arrayWithObjects:@"guide_page1",@"guide_page1",@"guide_page3", nil];
    [self setupUI];
    
}
-(void)viewDidLayoutSubviews{
    if (kIPhoneX) {
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-154);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@12);
        }];
    }else{
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-120);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@12);
        }];
    }
}
//点击方法
-(void)tapAction:(UITapGestureRecognizer *)tap{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController =[[BaseTabBarViewController alloc] init];
}

#pragma mark---ScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获得偏移量
    float offsetX =  scrollView.contentOffset.x;
    //判断左右滚动的标识,1向右滑动，0向左滑动
    NSInteger flag = offsetX /kScreenWidth >= 1 ? 1 : 0;
    if (flag) {
        self.pageControl.currentPage = self.pageControl.currentPage+1;
    }else{
        self.pageControl.currentPage = self.pageControl.currentPage-1;
    }
}

#pragma mark---UI
-(void)setupUI{
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        [self.scrollView addSubview:imageView];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_page%d.png",i+1]];
        if (i == 2) {
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:tap];
        }
    }
}

#pragma MARK--懒加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth *3, kScreenHeight);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.backgroundColor = [UIColor whiteColor];
        //默认点的颜色
        pageControl.pageIndicatorTintColor = grayTexColor;
        //当前点的颜色
        pageControl.currentPageIndicatorTintColor = selectedTexColor;
        //页数对应点数
        pageControl.numberOfPages = self.imagesList.count;
        pageControl.currentPage = 0;
        _pageControl = pageControl;
    }
    return _pageControl;
}
@end
