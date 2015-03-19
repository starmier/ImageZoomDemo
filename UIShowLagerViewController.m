//
//  UIShowLagerViewController.m
//  ImageZoomDemo
//
//  Created by LYG on 15/3/19.
//  Copyright (c) 2015年 cndatacom. All rights reserved.
//

#import "UIShowLagerViewController.h"

#define IOS7_OR_LATER ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

#define IsiPhoneDevice(w,h) if([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] || [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]){\
w = [[UIScreen mainScreen] bounds].size.width; \
h = [[UIScreen mainScreen] bounds].size.height;}\
else if([[[UIDevice currentDevice] model] isEqualToString:@"iPad"] || [[[UIDevice currentDevice] model] isEqualToString:@"iPad Simulator"]){\
w = [[UIScreen mainScreen] bounds].size.height; \
h = [[UIScreen mainScreen] bounds].size.width;}




@interface UIShowLagerViewController ()<UIScrollViewDelegate>{
    CGFloat _SWidth;
    CGFloat _Sheight;
    
    NSMutableArray *_myPicArr;//存放要查看的资源(元素内容：(url))
    NSInteger _curShowIndex;//开始查看图片资源，当前选中的资源的位置
    NSInteger _selecetedIndex;//查看过程中，当前所查看资源所在位置
    
    UILabel *_curIndexLabel;
}

@end

@implementation UIShowLagerViewController

-(id)initWithPicArr:(NSArray *)mutArr  andCurIndex:(NSInteger)curIndex{
    self = [super init];
    if (self) {
        _myPicArr = [[NSMutableArray alloc]initWithArray:mutArr];
        _curShowIndex = curIndex;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat top = 0.0f;
    if (IOS7_OR_LATER) {
        top += 20.0f;
    }
    
    IsiPhoneDevice(_SWidth, _Sheight);
    _Sheight -= 20;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:122 green:122 blue:122 alpha:0.868f]];
    
    
    //当前浏览的下标/总数量
    _curIndexLabel = [[UILabel alloc]initWithFrame:CGRectMake((_SWidth - 150)/2, _Sheight - 50 + top, 150, 30)];
    _curIndexLabel.text = [NSString stringWithFormat:@"%ld/%lu",_curShowIndex + 1,(unsigned long)_myPicArr.count];
    _curIndexLabel.textAlignment = NSTextAlignmentCenter;
    _curIndexLabel.backgroundColor = [UIColor clearColor];
    _curIndexLabel.textColor = [UIColor whiteColor];
    
    
    _Sheight -= 50;
    
    
    //back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 44 - 40 + top, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_press.png"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_press.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backToDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    
    top += 44;
    _Sheight -= 44;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, top, _SWidth, _Sheight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [_scrollView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_scrollView];
    
    [_scrollView release];
    
    [_scrollView setContentSize:CGSizeMake(_SWidth * _myPicArr.count, _Sheight)];
    
    for (int i = 0; i < _myPicArr.count; i++) {
        
        CGRect frame = _scrollView.frame;
        
        frame.origin.x = frame.size.width * i;
        frame.origin.y = (frame.size.height - 200)/2;
        frame.size.height = 200;
        _zoomScrollView = [[ZoomScrollView alloc]initWithFrame:frame];
        _zoomScrollView.ZoomDelegate = self;
        _zoomScrollView.backgroundColor = [UIColor clearColor];
        _zoomScrollView.tag = i;

        _zoomScrollView.imageView.image = [UIImage imageNamed:_myPicArr[i]];
        
        [_scrollView addSubview:_zoomScrollView];
        [_zoomScrollView release];
    }
    
    
    [self.view addSubview:_curIndexLabel];
    [self.view addSubview:backBtn];
}
-(void)backToDetail:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -- ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger curIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
    _curIndexLabel.text = [NSString stringWithFormat:@"%ld/%lu",curIndex + 1,(unsigned long)_myPicArr.count];
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
