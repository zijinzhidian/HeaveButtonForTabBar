//
//  YWNavigationController.m
//  HeaveButtonForTabBar
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 zjbojin. All rights reserved.
//

#import "YWNavigationController.h"

@interface YWNavigationController ()

@end

@implementation YWNavigationController

//load方法会在main函数之前加载
+ (void)load {

    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    bar.barTintColor = [UIColor colorWithRed:250/255.0 green:227/255.0 blue:111/255.0 alpha:1.0];
    
}

//重写跳转方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    return [super pushViewController:viewController animated:animated];
}

@end
