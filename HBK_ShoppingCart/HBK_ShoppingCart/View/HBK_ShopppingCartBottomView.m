//
//  HBK_ShopppingCartBottomView.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShopppingCartBottomView.h"

@implementation HBK_ShopppingCartBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)allClickBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
    if (self.AllClickBlock) {
        self.AllClickBlock(sender.selected);
    }
}

- (IBAction)accountBtn:(UIButton *)sender {
    if (self.AccountBlock) {
        self.AccountBlock();
    }
}

- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    self.clickBtn.selected = isClick;
    if (isClick) {
        [self.clickBtn setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [self.clickBtn setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
}

@end
