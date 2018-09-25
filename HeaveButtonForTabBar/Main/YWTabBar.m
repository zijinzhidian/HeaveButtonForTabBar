//
//  YWTabBar.m
//  HeaveButtonForTabBar
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 zjbojin. All rights reserved.
//

#import "YWTabBar.h"
#import "UIView+LBExtension.h"

static CGFloat const kMargin = 15;

@interface YWTabBar ()
@property(nonatomic,strong)UIButton *plusButton;
@property(nonatomic,strong)UILabel *plusLabel;
@end

@implementation YWTabBar

#pragma mark - Inital
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.plusButton];
        [self addSubview:self.plusLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.plusButton.centerX = self.centerX;
    self.plusButton.centerY = self.height * 0.5 - 2 * kMargin;
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    
    self.plusLabel.centerX = self.plusButton.centerX;
    self.plusLabel.centerY = CGRectGetMaxY(self.plusButton.frame) + kMargin;
    
    //系统自带的按钮类型是UITabBarButton,找出这种类型的按钮,然后重新布局
    Class class = NSClassFromString(@"UITabBarButton");
    
    //遍历TabBar的字控件
    int index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:class]) {
    
            view.width = self.width / 5;
            view.x = view.width * index;
            
            index ++;
            if (index == 2) {
                index ++;
            }
        }
    }
    
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
    
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newPoint = [self convertPoint:point toView:self.plusButton];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ([self.plusButton pointInside:newPoint withEvent:event]) {
            
            return self.plusButton;
            
        } else {//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
            
        }
        
    } else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
    
}

#pragma mark - Actions
- (void)plusButtonDidClick:(UIButton *)sender {
    if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(tabBarPlusButtonDidClick:)]) {
        [self.tabBarDelegate tabBarPlusButtonDidClick:self];
    }
}


#pragma mark - Getters And Setters
- (UIButton *)plusButton {
    if (!_plusButton) {
        
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        [_plusButton addTarget:self action:@selector(plusButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _plusButton;
}

- (UILabel *)plusLabel {
    if (!_plusLabel) {
        
        _plusLabel = [[UILabel alloc] init];
        _plusLabel.text = @"发布";
        _plusLabel.font = [UIFont systemFontOfSize:11];
        _plusLabel.textColor = [UIColor grayColor];
        [_plusLabel sizeToFit];
        
    }
    return _plusLabel;
}

@end
