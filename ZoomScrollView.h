//
//  ZoomScrollView.h
//  ImageZoomDemo
//
//  Created by LYG on 15/3/19.
//  Copyright (c) 2015年 cndatacom. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZoomScrollView : UIScrollView<UIScrollViewDelegate>

{
    UIImageView *imageView;
}

@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic,assign) id<ZoomScrollViewDelegate> ZoomDelegate;

@end
