//
//  CQTabBarController.m
//  CQBlog
//
//  Created by legend on 2017/6/21.
//  Copyright © 2017年 legend. All rights reserved.
//

#import "CQTabBarController.h"
#import "CQTabBar.h"

@interface CQTabBarController ()

@end

@implementation CQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 自定义tabBar
    CQTabBar *tabBar = [[CQTabBar alloc] initWithFrame:self.tabBar.frame];
    // 利用KVC把readly的属性改
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
