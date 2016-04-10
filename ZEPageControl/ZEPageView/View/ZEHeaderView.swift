//
//  ZEHeaderView.swift
//  ZEPageView
//
//  Created by 胡春源 on 16/3/16.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit



class ZEHeaderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 分割线..没啥用
        let line = UIView(frame: CGRectMake(0,self.frame.height-1,kZEScreenWidth,1))
        line.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.addSubview(line)
    }
}
