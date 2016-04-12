//
//  ZEHeaderView.swift
//  ZEPageView
//
//  Created by 胡春源 on 16/3/16.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit



class ZEHeaderView: UIView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    

    @IBAction func buttonClick(sender: UIButton) {
        if sender.tag == 10086 {
            print("掘金")
        }else if sender.tag == 10087 {
            print("简书")
        }else if sender.tag == 10088 {
            print("github")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        goldButton.layer.masksToBounds = true
//        goldButton.layer.cornerRadius = goldButton.frame.size.width/2
        
        
        
        // 分割线..没啥用
        let line = UIView(frame: CGRectMake(0,self.frame.height-1,kZEScreenWidth,1))
        line.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.addSubview(line)
    }
}
