//
//  ZoomScrollView.m
//  ImageZoomDemo
//
//  Created by LYG on 15/3/19.
//  Copyright (c) 2015年 cndatacom. All rights reserved.
//

#import "ZoomScrollView.h"

@interface ZoomScrollView (zoom)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation ZoomScrollView

@synthesize imageView,ZoomDelegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        //        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        self.frame = frame;
        [self initImageView];
    }
    return self;
}

- (void)initImageView
{
    imageView = [[UIImageView alloc]init];
    
    // The imageView can be zoomed largest size
    imageView.frame = CGRectMake(0, 0, self.frame.size.width* 2.5, self.frame.size.height * 2.5);
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    [imageView release];
    
    // Add gesture,double tap zoom imageView.
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];//设定事件触发所需要的点击次数，即只处理某种点击次数的事件请求，默认值为1
    [imageView addGestureRecognizer:doubleTapGesture];
    [doubleTapGesture release];
    
    float minimumScale = self.frame.size.width / imageView.frame.size.width;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
}


#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    float newScale = self.zoomScale * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
    [self zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    //实现缩放
    
    [scrollView setZoomScale:scale animated:NO];
    
    
    CGSize size = view.frame.size;
    CGRect frame = self.frame;
    UIScrollView *scrollview = (UIScrollView *)[self superview];
    CGFloat origin = (scrollview.frame.size.height - size.height)/2;
    frame.origin.y = origin>=0.0f?origin:0.0f;
    frame.size.height = size.height<=scrollview.frame.size.height?size.height:scrollview.frame.size.height;
    self.frame = frame;
    
}



#pragma mark - View cycle
- (void)dealloc
{
    [super dealloc];
}


@end
