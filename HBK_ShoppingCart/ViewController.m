//
//  ViewController.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "ViewController.h"
#import "HBK_ShoppingCartViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)goShoppingCart:(UIButton *)sender {
    HBK_ShoppingCartViewController *shoppingCartVC = [[HBK_ShoppingCartViewController alloc] init];
    shoppingCartVC.isSubPage = YES;
    [self.navigationController pushViewController:shoppingCartVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
