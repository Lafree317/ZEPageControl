//
//  ZEViewController.swift
//  ZEPageView
//
//  Created by 胡春源 on 16/3/16.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ZEPageViewController: UIViewController,UIScrollViewDelegate,ZETableViewControllerDelegate,ZEMenuViewDelegate {
    var titlesArr:Array<String>!
    var backGroundScrollView:UIScrollView?
    var tableViewArr:Array<ZETableViewController> = []
    var showingTableView:UITableView?
    var menuView:ZEMenuView!
    var headerView:ZEHeaderView!
    var scrollY:CGFloat = 0
    var scrollX:CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.backGroundScrollView = UIScrollView(frame: self.view.frame)
        self.backGroundScrollView?.pagingEnabled = true
        self.backGroundScrollView?.bounces = false
        self.backGroundScrollView?.delegate = self
        
        let floatArrCount = CGFloat(titlesArr.count)
        self.backGroundScrollView?.contentSize = CGSizeMake(floatArrCount*kZEScreenWidth,self.view.frame.size.height-64)
        // tableView自己持有的偏移量和赋值时给的偏移量符号是相反的
        scrollY = -kScrollHorizY
        for  i in 0 ..< titlesArr.count  {
            let floatI = CGFloat(i)
            
            let tableViewVC = ZETableViewController(style: UITableViewStyle.Plain)
            tableViewVC.tableView.contentInset = UIEdgeInsetsMake(kScrollHorizY, 0, 0, 0 )
            tableViewVC.delegate = self
            tableViewVC.view.frame = CGRectMake(floatI * kZEScreenWidth,0, self.view.frame.size.width, self.view.frame.size.height-64)
            tableViewVC.tags = titlesArr[i]
            
            tableViewArr.append(tableViewVC)
            self.addChildViewController(tableViewVC)
        }
        backGroundScrollView?.addSubview(tableViewArr[0].view)
        self.view .addSubview(backGroundScrollView!)
        
        headerView = NSBundle.mainBundle().loadNibNamed("ZEHeaderView", owner: self, options: nil).first as! ZEHeaderView
        headerView.frame = CGRectMake(0, 64, kZEScreenWidth, kZEHeaderHight)
        self.view .addSubview(headerView)
        
        menuView = ZEMenuView(frame:CGRectMake(0,kZEHeaderHight+64,kZEScreenWidth,kZEMenuHight))
        menuView.delegate = self
        menuView.setUIWithArr(titlesArr)
        self.view .addSubview(self.menuView)
    }
    func headerMenuViewShowType(showType:headerMenuShowType){
        switch showType {
        case .up:
            menuView.frame.origin.y = 64
            headerView.frame.origin.y = 64-kZEHeaderHight
            break
        case .buttom:
            headerView.frame.origin.y = 64
            menuView.frame.origin.y = CGRectGetMaxY(headerView.frame)
            break
        }
    }
    func menuViewSelectIndex(index: Int) {
        UIView.animateWithDuration(0.3) { 
            self.backGroundScrollView?.contentOffset = CGPointMake(kZEScreenWidth*CGFloat(index),-64)
        }
    }
    func tableViewDidScrollPassY(tableviewScrollY: CGFloat) {
        let  seleoffSetY = tableviewScrollY - scrollY
        scrollY = tableviewScrollY
        if scrollY >= -kZEMenuHight {
            headerMenuViewShowType(.up)
        }else if  scrollY <= -kScrollHorizY {
            headerMenuViewShowType(.buttom)
        }else{
            headerView.frame.origin.y -= seleoffSetY
            menuView.frame.origin.y = CGRectGetMaxY(headerView.frame)
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollX != scrollView.contentOffset.x{
            if scrollY >= -kZEMenuHight {
                scrollY = -kZEMenuHight
            }
            for tableViewVC in tableViewArr {
                tableViewVC.tableView.contentOffset = CGPointMake(0, scrollY)
            }
            
            let rate = (scrollView.contentOffset.x/kZEScreenWidth)
            backGroundScrollView?.addSubview(tableViewArr[Int(rate+0.5)].view)
            self.menuView.scrollToRate(rate)
            
        }
        scrollX = scrollView.contentOffset.x
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
