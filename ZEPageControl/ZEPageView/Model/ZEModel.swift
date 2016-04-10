//
//  ZEModel.swift
//  ZEPageView
//
//  Created by 胡春源 on 16/3/16.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

let kZEScreenWidth = UIScreen.mainScreen().bounds.size.width
let kZEScreenHight = UIScreen.mainScreen().bounds.size.height
let kZEButtonWidth:CGFloat = 75
let kZEHeaderHight:CGFloat = 135
let kScrollHorizY = kZEMenuHight+kZEHeaderHight



let kZEMenuHight:CGFloat = 50
let kNavigationHight:CGFloat = 64

enum headerMenuShowType:UInt {
    case up = 1
    case buttom = 2
}
let COLOR_BUTTON_DEFAULT = UIColor.init(red: 124/255.0, green: 129/255.0, blue: 138/255.0, alpha: 1)
let COLOR_BUTTON_SELECT = UIColor.init(red: 0/255.0, green: 127/255.0, blue: 255/255.0, alpha: 1)

