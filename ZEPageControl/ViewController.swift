//
//  ViewController.swift
//  ZEPageControl
//
//  Created by 胡春源 on 16/4/10.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let zeVC = ZEPageViewController()
        zeVC.titlesArr = ["动态","问题","讨论"]
        self.addChildViewController(zeVC)
        self.view.addSubview(zeVC.view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

