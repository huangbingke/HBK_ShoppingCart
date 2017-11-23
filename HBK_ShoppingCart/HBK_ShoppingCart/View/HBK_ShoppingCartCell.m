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
    if (self.CutBlock) {
        self.CutBlock(self.countLabel);
    }
}

//加
- (IBAction)add:(UIButton *)sender {
    if (self.AddBlock) {
        self.AddBlock(self.countLabel);
    }
}

//选中
- (IBAction)click:(id)sender {


}

- (void)setGoodsModel:(HBK_GoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    if ([goodsModel.count integerValue] > 0) {
        //库存大于0, 选中按钮正常显示
        [self.clickBtn setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
        self.clickBtn.userInteractionEnabled = YES;
    } else {
        //库存小于零, 显示
        self.clickBtn.userInteractionEnabled = NO;
        [self.clickBtn setTitle:@"失效" forState:(UIControlStateNormal)];
        self.clickBtn.backgroundColor = [UIColor lightGrayColor];
    }
    self.goodImageView.backgroundColor = kRandomColor;
    self.goodsNameLabel.text = goodsModel.goodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元", goodsModel.realPrice];
    self.brandLabel.text = [NSString stringWithFormat:@"%@", goodsModel.shopName];
}





@end
