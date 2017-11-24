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
    
    HBK_ShopppingCartBottomView *bottomView = [[[NSBundle mainBundle] loadNibNamed:@"HBK_ShopppingCartBottomView" owner:nil options:nil] objectAtIndex:0];
    bottomView.frame = CGRectMake(0, kScreenHeight - tabBarHeight - kBottomHeight, kScreenWidth, kBottomHeight);
    //全选
    bottomView.AllClickBlock = ^{
        
    };
    [self.view addSubview:bottomView];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.storeArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HBK_StoreModel *storeModel = self.storeArray[section];
    return storeModel.goods.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBK_ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBK_ShoppingCartCell"];
    HBK_StoreModel *storeModel = self.storeArray[indexPath.section];
    HBK_GoodsModel *goodsModel = storeModel.goodsArray[indexPath.row];
    cell.goodsModel = goodsModel;
    
    //选中某一行
    cell.ClickRowBlock = ^(BOOL isClick) {
        goodsModel.isSelect = isClick;
        if (isClick) {//选中
            
        } else {//取消选中
            
        }
    };
    //加
    cell.AddBlock = ^(UILabel *countLabel) {
        
        
    };
    //减
    cell.CutBlock = ^(UILabel *countLabel) {
        
        
    };
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
    //选中一个分区
    headerView.ClickBlock = ^{
        
    };
    return headerView;
}

#pragma mark ------------------------Action-----------------------------
//- (void)




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
