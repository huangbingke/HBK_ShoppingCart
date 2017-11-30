//
//  HBK_ShoppingCartViewController.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartViewController.h"
#import "HBK_ShoppingCartModel.h"
#import "HBK_ShoppingCartCell.h"
#import "HBK_ShoppingCartHeaderView.h"
#import "HBK_ShopppingCartBottomView.h"
#define kBottomHeight        kFit(50)

@interface HBK_ShoppingCartViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray<HBK_StoreModel *> *storeArray;
@property (nonatomic, strong) HBK_ShopppingCartBottomView *bottomView;
/**
 选中的数组
 */
@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation HBK_ShoppingCartViewController

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        self.selectArray = [NSMutableArray new];
    }
    return _selectArray;
}
- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        self.storeArray = [NSMutableArray new];
    }
    return _storeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";
    [self setSubViews];
    
    [self loadingDataForPlist];
    
}
#pragma  mark --------------------- UI ------------------
- (void)setSubViews {
    CGFloat tabBarHeight = kTabBarHeight;
    if (self.isSubPage) {
        tabBarHeight = kTabBarHeight-49;
    } else {
        tabBarHeight = kTabBarHeight;
    }
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight-tabBarHeight - kBottomHeight) style:(UITableViewStyleGrouped)];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    self.myTableView.tableFooterView = [[UIView alloc] init];
    [self.myTableView registerNib:[UINib nibWithNibName:@"HBK_ShoppingCartCell" bundle:nil] forCellReuseIdentifier:@"HBK_ShoppingCartCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"HBK_ShoppingCartHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HBK_ShoppingCartHeaderView"];
    
    self.bottomView = [[[NSBundle mainBundle] loadNibNamed:@"HBK_ShopppingCartBottomView" owner:nil options:nil] objectAtIndex:0];
    self.bottomView.frame = CGRectMake(0, kScreenHeight - tabBarHeight - kBottomHeight, kScreenWidth, kBottomHeight);
    //全选
    [self clickAllSelectBottomView:self.bottomView];
    
    [self.view addSubview:self.bottomView];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.storeArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HBK_StoreModel *storeModel = self.storeArray[section];
    return storeModel.goodsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBK_ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBK_ShoppingCartCell"];
    HBK_StoreModel *storeModel = self.storeArray[indexPath.section];
    HBK_GoodsModel *goodsModel = storeModel.goodsArray[indexPath.row];
    cell.goodsModel = goodsModel;
    //把事件的处理分离出去
    [self shoppingCartCellClickAction:cell storeModel:storeModel goodsModel:goodsModel indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kFit(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HBK_ShoppingCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HBK_ShoppingCartHeaderView"];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    HBK_StoreModel *storeModel = self.storeArray[section];
    headerView.storeModel = storeModel;
    //分区区头点击事件--- 把事件分离出去
    [self clickSectionHeaderView:headerView andHBK_StoreModel:storeModel];
    return headerView;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        kWeakSelf(self);
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            kStrongSelf(self);
            [self deleteGoodsWithIndexPath:indexPath];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleDefault) handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark ------------------------Action 逻辑处理-----------------------------

/**
 判断分区有没有被全选
 @param section 分区坐标
 */
- (void)judgeIsSelectSection:(NSInteger)section {
    HBK_StoreModel *storeModel = self.storeArray[section];
    BOOL isSelectSection = YES;
    //遍历分区商品, 如果有商品的没有被选择, 跳出循环, 说明没有全选
    for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
        if (goodsModel.isSelect == NO) {
            isSelectSection = NO;
            break;
        }
    }
    //全选了以后, 改变一下选中状态
    HBK_ShoppingCartHeaderView *headerView = (HBK_ShoppingCartHeaderView *)[self.myTableView headerViewForSection:section];
    headerView.isClick = isSelectSection;
    storeModel.isSelect = isSelectSection;
}

/**
 是否全选
 */
- (void)judgeIsAllSelect {
    NSInteger count = 0;
    //先遍历购物车商品, 得到购物车有多少商品
    for (HBK_StoreModel *storeModel in self.storeArray) {
        count += storeModel.goodsArray.count;
    }
    //如果购物车总商品数量 等于 选中的商品数量, 即表示全选了
    if (count == self.selectArray.count) {
        self.bottomView.isClick = YES;
    } else {
        self.bottomView.isClick = NO;
    }   
}


/**
 计算价格
 */
- (void)countPrice {
    double totlePrice = 0.0;
    for (HBK_GoodsModel *goodsModel in self.selectArray) {
        double price = [goodsModel.realPrice doubleValue];
        totlePrice += price * [goodsModel.count integerValue];
    }
    self.bottomView.allPriceLabel.text = [NSString stringWithFormat:@"合计 ￥%.2f", totlePrice];
}



#pragma mark  ----------- Action 点击事件 --------------------
/**
 区头点击----选中某个分区/取消选中某个分区
 @param headerView 分区
 @param storeModel 分区模型
 */
- (void)clickSectionHeaderView:(HBK_ShoppingCartHeaderView *)headerView andHBK_StoreModel:(HBK_StoreModel *)storeModel {
    headerView.ClickBlock = ^(BOOL isClick) {
        storeModel.isSelect = isClick;
        
        if (isClick) {//选中
            NSLog(@"选中");
            for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
                goodsModel.isSelect = YES;
                if (![self.selectArray containsObject:goodsModel]) {
                    [self.selectArray addObject:goodsModel];
                }
            }

        } else {//取消选中
            NSLog(@"取消选中");
            for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
                goodsModel.isSelect = NO;
                if ([self.selectArray containsObject:goodsModel]) {
                    [self.selectArray removeObject:goodsModel];
                }
            }
        }
        [self judgeIsAllSelect];
        [self.myTableView reloadData];
        [self countPrice];
    };
}


/**
 全选点击---逻辑处理
 @param bottomView 底部的View
 */
- (void)clickAllSelectBottomView:(HBK_ShopppingCartBottomView *)bottomView {
    kWeakSelf(self);
    bottomView.AllClickBlock = ^(BOOL isClick) {
        kStrongSelf(self);
        for (HBK_GoodsModel *goodsModel in self.selectArray) {
            goodsModel.isSelect = NO;
        }
        [self.selectArray removeAllObjects];
        if (isClick) {//选中
            NSLog(@"全选");
            for (HBK_StoreModel *storeModel in self.storeArray) {
                storeModel.isSelect = YES;
                for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
                    goodsModel.isSelect = YES;
                    [self.selectArray addObject:goodsModel];
                }
            }
        } else {//取消选中
            NSLog(@"取消全选");
            for (HBK_StoreModel *storeModel in self.storeArray) {
                storeModel.isSelect = NO;
            }
        }
        [self.myTableView reloadData];
        [self countPrice];
    };
    
    bottomView.AccountBlock = ^{
        NSLog(@"去结算");
    };
    
    
}

- (void)shoppingCartCellClickAction:(HBK_ShoppingCartCell *)cell
                         storeModel:(HBK_StoreModel *)storeModel
                         goodsModel:(HBK_GoodsModel *)goodsModel
                          indexPath:(NSIndexPath *)indexPath {
    //选中某一行
    cell.ClickRowBlock = ^(BOOL isClick) {
        goodsModel.isSelect = isClick;
        if (isClick) {//选中
            NSLog(@"选中");
            [self.selectArray addObject:goodsModel];
        } else {//取消选中
            NSLog(@"取消选中");
            [self.selectArray removeObject:goodsModel];
        }
        
        [self judgeIsSelectSection:indexPath.section];
        [self judgeIsAllSelect];
        [self countPrice];
    };
    //加
    cell.AddBlock = ^(UILabel *countLabel) {
        NSLog(@"%@", countLabel.text);
        goodsModel.count = countLabel.text;
        [storeModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        if ([self.selectArray containsObject:goodsModel]) {
            [self.selectArray removeObject:goodsModel];
            [self.selectArray addObject:goodsModel];
            [self countPrice];
        }
        
    };
    //减
    cell.CutBlock = ^(UILabel *countLabel) {
        NSLog(@"%@", countLabel.text);
        goodsModel.count = countLabel.text;
        [storeModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        if ([self.selectArray containsObject:goodsModel]) {
            [self.selectArray removeObject:goodsModel];
            [self.selectArray addObject:goodsModel];
            [self countPrice];
        }
    };
}


/**
 删除某个商品
 @param indexPath 坐标
 */
- (void)deleteGoodsWithIndexPath:(NSIndexPath *)indexPath {
    HBK_StoreModel *storeModel = [self.storeArray objectAtIndex:indexPath.section];
    HBK_GoodsModel *goodsModel = [storeModel.goodsArray objectAtIndex:indexPath.row];
    [storeModel.goodsArray removeObjectAtIndex:indexPath.row];
    [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    if (storeModel.goodsArray.count == 0) {
        [self.storeArray removeObjectAtIndex:indexPath.section];
    }
    
    if ([self.selectArray containsObject:goodsModel]) {
        [self.selectArray removeObject:goodsModel];
        [self countPrice];
    }
    
    NSInteger count = 0;
    for (HBK_StoreModel *storeModel in self.storeArray) {
        count += storeModel.goodsArray.count;
    }
    if (self.selectArray.count == count) {
        _bottomView.clickBtn.selected = YES;
    } else {
        _bottomView.clickBtn.selected = NO;
    }
    
    if (count == 0) {
        //此处加载购物车为空的视图
        
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTableView reloadData];
    });
}






#pragma mark  -------------------- 此处模仿网络请求, 加载plist文件内容
- (void)loadingDataForPlist {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShopCarNew" ofType:@"plist"];
    NSDictionary *dataDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"%@", dataDic);
    NSArray *dataArray = dataDic[@"data"];
    if (dataArray.count > 0) {
        for (NSDictionary *dic in dataArray) {
            HBK_StoreModel *model = [[HBK_StoreModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.storeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
        
    } else {
        //加载数据为空时的展示
        
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
