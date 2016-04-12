//
//  ZEModel.swift
//  ZEPageView
//
//  Created by 胡春源 on 16/3/16.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

/** 屏幕宽度高度 */
let kZEScreenWidth = UIScreen.mainScreen().bounds.size.width
let kZEScreenHight = UIScreen.mainScreen().bounds.size.height

/** header和menu的高度 */
let kZEHeaderHight:CGFloat = 200
let kZEMenuHight:CGFloat = 40
let kScrollHorizY = kZEMenuHight+kZEHeaderHight

let kNavigationHight:CGFloat = 64

/** 偏移方法操作枚举 */
enum headerMenuShowType:UInt {
    case up = 1 // 固定在navigation上面
    case buttom = 2 // 固定在navigation下面
}

/** button两种状态的颜色 可以无视 */
let COLOR_BUTTON_DEFAULT = UIColor.init(red: 124/255.0, green: 129/255.0, blue: 138/255.0, alpha: 1)
let COLOR_BUTTON_SELECT = UIColor.init(red: 0/255.0, green: 127/255.0, blue: 255/255.0, alpha: 1)

