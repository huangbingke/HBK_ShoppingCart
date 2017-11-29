//
//  HBK_ShoppingCartCell.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartCell.h"

@implementation HBK_ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//减
- (IBAction)cut:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count--;
    if (count <= 0) {
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
    if (self.CutBlock) {
        self.CutBlock(self.countLabel);
    }
}

//加
- (IBAction)add:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
    if (self.AddBlock) {
        self.AddBlock(self.countLabel);
    }
}

//选中
- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
    if (self.ClickRowBlock) {
        self.ClickRowBlock(sender.selected);
    }
}

- (void)setGoodsModel:(HBK_GoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    self.clickBtn.selected = goodsModel.isSelect;
    if (goodsModel.isSelect) {
        [self.clickBtn setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [self.clickBtn setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%@", goodsModel.count];
    self.goodImageView.backgroundColor = kRandomColor;
    self.goodsNameLabel.text = goodsModel.goodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元", goodsModel.realPrice];
    self.brandLabel.text = [NSString stringWithFormat:@"%@", goodsModel.shopName];
}




@end
