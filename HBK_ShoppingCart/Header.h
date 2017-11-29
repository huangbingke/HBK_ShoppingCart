//
//  Header.h
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#ifndef Header_h
#define Header_h


#endif /* Header_h */


//系统版本号
#define kSystemCurrentDevice             [[UIDevice currentDevice] systemVersion];
#define IOS_FSystenVersion              ([[[UIDevice currentDevice] systemVersion] floatValue])

#pragma mark --------------------- 尺寸 ----------------------------
//屏幕的宽度
#define kScreenWidth            [[UIScreen mainScreen] bounds].size.width

//屏幕的高度
#define kScreenHeight           [[UIScreen mainScreen] bounds].size.height


//打包和结算的高度
#define kAllBarHeight           40

//导航栏高度
#define kNavBarHeight           (kScreenHeight == 812 ? 88 : 64)

//tabBar高度
#define kTabBarHeight           (kScreenHeight == 812 ? 83 : 49)

//NavigationBar和TabBar的高度
#define kNBarTBarHeight         (kNavBarHeight + kTabBarHeight)

//如果是iPhoneX 底部留空隙34, 如果不是空隙为0
#define kIPhoneXBottomHeight    (kScreenHeight == 812 ? 34 : 0)

//比例 以iPhone6 为基准
#define kRatio kScreenWidth/375

//按比例适配
#define kFit(num)                 kRatio * (num)


//随机颜色
#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 255. green:arc4random() % 256 / 255. blue:arc4random() % 256 / 255. alpha:1]



#define kWeakSelf(type)__weak typeof(type)weak##type = type;

#define kStrongSelf(type)__strong typeof(type)type = weak##type;














