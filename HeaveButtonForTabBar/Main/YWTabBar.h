//
//  YWTabBar.h
//  HeaveButtonForTabBar
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 zjbojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YWTabBar;

@protocol YWTabBarDelegate<NSObject>
- (void)tabBarPlusButtonDidClick:(YWTabBar *)tabBar;
@end

@interface YWTabBar : UITabBar
@property(nonatomic,weak)id<YWTabBarDelegate> tabBarDelegate;
@end
