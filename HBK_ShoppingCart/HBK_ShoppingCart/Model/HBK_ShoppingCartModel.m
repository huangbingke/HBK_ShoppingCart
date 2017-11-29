//
//  HBK_ShoppingCartModel.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartModel.h"

@implementation HBK_StoreModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.goodsArray = [NSMutableArray new];
    }
    return self;
}

- (void)setGoods:(NSMutableArray<HBK_GoodsModel *> *)goods {
    _goods = goods;
    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSDictionary *dic in goods) {
        HBK_GoodsModel *model = [[HBK_GoodsModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [tempArray addObject:model];
    }
    self.goodsArray = [NSMutableArray arrayWithArray: tempArray];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end

@implementation HBK_GoodsModel

@end
