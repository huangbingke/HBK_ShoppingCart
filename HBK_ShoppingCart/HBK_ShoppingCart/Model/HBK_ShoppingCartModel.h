//
//  HBK_ShoppingCartModel.h
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HBK_GoodsModel;

@interface HBK_StoreModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSArray *goods;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *sid;



@property (nonatomic, strong) NSMutableArray *goodsArray;
@property (nonatomic, assign) BOOL isSelect;

@end



@interface HBK_GoodsModel : NSObject

@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsType;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *orginalPrice;
@property (nonatomic, copy) NSString *realPrice;
@property (nonatomic, copy) NSString *shopId;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) BOOL isSelect;



@end
