//
//  HBK_ShoppingCartHeaderView.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartHeaderView.h"

@implementation HBK_ShoppingCartHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
    if (self.clickBtn) {
        self.ClickBlock(sender.selected);
    }
}

- (void)setStoreModel:(HBK_StoreModel *)storeModel {
    self.storeNameLabel.text = storeModel.shopName;
    self.isClick = storeModel.isSelect;
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
