//
//  PostViewController.m
//  HeaveButtonForTabBar
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 zjbojin. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)pop {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
