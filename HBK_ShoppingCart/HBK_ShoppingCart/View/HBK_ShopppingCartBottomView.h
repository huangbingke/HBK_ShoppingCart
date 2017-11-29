//
//  HBK_ShopppingCartBottomView.h
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBK_ShopppingCartBottomView : UIView



@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;

@property (nonatomic, copy) void (^AllClickBlock)(BOOL isClick);
@property (nonatomic, copy) void (^AccountBlock)();

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (nonatomic, assign) BOOL isClick;

@end
