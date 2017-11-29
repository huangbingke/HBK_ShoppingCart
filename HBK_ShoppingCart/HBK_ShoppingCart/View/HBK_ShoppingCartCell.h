//
//  HBK_ShoppingCartCell.h
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBK_ShoppingCartModel.h"
@interface HBK_ShoppingCartCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;//数量

@property (weak, nonatomic) IBOutlet UIButton *cutBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;



/**
 选中
 */
@property (nonatomic, copy) void (^ClickRowBlock)(BOOL isClick);

/**
 加
 */
@property (nonatomic, copy) void (^AddBlock)(UILabel *countLabel);

/**
 减
 */
@property (nonatomic, copy) void (^CutBlock)(UILabel *countLabel);


@property (nonatomic, strong) HBK_GoodsModel *goodsModel;



@end
