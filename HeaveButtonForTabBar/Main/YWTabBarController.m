//
//  YWTabBarController.m
//  HeaveButtonForTabBar
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 zjbojin. All rights reserved.
//

#import "YWTabBarController.h"

#import "YWNavigationController.h"
#import "YWTabBar.h"

#import "HomeViewController.h"
#import "FishViewController.h"
#import "PostViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

@interface YWTabBarController ()<YWTabBarDelegate>

@end

@implementation YWTabBarController

#pragma mark - Initail
+ (void)initialize {
    
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
    
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildVC];
    
    //创建自定义TabBar,利用KVC将自定义的TabBar和系统的TabBar替换
    YWTabBar *tabBar = [[YWTabBar alloc] init];
    tabBar.tabBarDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    
}

#pragma mark - Actions
- (void)setUpAllChildVC {
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setUpOneChildVCWithVC:homeVC image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];
    
    FishViewController *fishVC = [[FishViewController alloc] init];
    [self setUpOneChildVCWithVC:fishVC image:@"fish_normal" selectedImage:@"fish_highlight" title:@"鱼塘"];
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    [self setUpOneChildVCWithVC:messageVC image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self setUpOneChildVCWithVC:mineVC image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
    
}

- (void)setUpOneChildVCWithVC:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    YWNavigationController *nav = [[YWNavigationController alloc] initWithRootViewController:vc];
    
    vc.view.backgroundColor = [self randomColor];
    
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.title = title;
    
    vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}

- (UIColor *)randomColor {
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

#pragma mark - YWTabBarDelegate
- (void)tabBarPlusButtonDidClick:(YWTabBar *)tabBar {
    PostViewController *postVC = [[PostViewController alloc] init];
    postVC.view.backgroundColor = [self randomColor];
    [self presentViewController:[[YWNavigationController alloc] initWithRootViewController:postVC] animated:YES completion:nil];
//    [self.childViewControllers[0] pushViewController:postVC animated:YES];
}

@end
