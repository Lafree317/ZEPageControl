//
//  ViewController.swift
//  ZEPageControlSwift
//
//  Created by 胡春源 on 16/5/7.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let zeVC = ZEPageViewController()
        zeVC.titlesArr = ["title1","title2","title3","title4"];
        self.addChildViewController(zeVC)
        self.view.addSubview(zeVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

