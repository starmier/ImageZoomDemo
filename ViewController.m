//
//  ViewController.m
//  ImageZoomDemo
//
//  Created by LYG on 15/3/19.
//  Copyright (c) 2015年 cndatacom. All rights reserved.
//

#import "ViewController.h"
#import "UIShowLagerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

#pragma mark -- 展示图片 放大
-(void)showLagerImageVCWithPics:(NSArray *)pics andCurIndex:(NSUInteger)curIndex{
    UIShowLagerViewController *lagerPicVC = [[UIShowLagerViewController alloc]initWithPicArr:pics andCurIndex:curIndex];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:lagerPicVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPicsAction:(UIButton *)sender {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<6; i++) {
        NSString *picName = [NSString stringWithFormat:@"nba%d.png",i];
        [arr addObject:picName];
    }
    
    [self showLagerImageVCWithPics:arr andCurIndex:0];
    
}
@end
