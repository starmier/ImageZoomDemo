//
//  UIShowLagerViewController.h
//  ImageZoomDemo
//
//  Created by LYG on 15/3/19.
//  Copyright (c) 2015年 cndatacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomScrollView.h"

@interface UIShowLagerViewController : UIViewController

@property (nonatomic, retain) UIScrollView      *scrollView;

@property (nonatomic, retain) ZoomScrollView  *zoomScrollView;

-(id)initWithPicArr:(NSArray *)mutArr  andCurIndex:(NSInteger)curIndex;

@end
