// 简书:http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317/ZEPageControl

import UIKit

class ZEPageViewController: UIViewController,UIScrollViewDelegate,ZETableViewControllerDelegate,ZEMenuViewDelegate {
    
    var titlesArr:Array<String>!
    var backgroundScrollView:UIScrollView?
    var tableViewArr:Array<ZETableViewController> = []
    var showingTableView:UITableView?
    var menuView:ZEMenuView!
    var headerView:ZEHeaderView!
    var scrollY:CGFloat = 0
    var scrollX:CGFloat = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        layoutBackgroundScrollView()
        layoutHeaderMenuView()
        
    }
    /** 创建底部scrollView,并将tableViewController添加到上面 */
    func layoutBackgroundScrollView(){
        // 需要创建到高度0上,所以backgroundScrollView.y要等于-64
        self.backgroundScrollView = UIScrollView(frame:CGRectMake(0,-kNavigationHight,kZEScreenWidth,kZEScreenHight+kNavigationHight))
        self.backgroundScrollView?.pagingEnabled = true
        self.backgroundScrollView?.bounces = false
        self.backgroundScrollView?.delegate = self
        let floatArrCount = CGFloat(titlesArr.count)
        self.backgroundScrollView?.contentSize = CGSizeMake(floatArrCount*kZEScreenWidth,self.view.frame.size.height-kNavigationHight)
        
        // 给scrollY赋初值避免一上来滑动就乱
        scrollY = -kScrollHorizY // tableView自己持有的偏移量和赋值时给的偏移量符号是相反的
        for  i in 0 ..< titlesArr.count  {
            let floatI = CGFloat(i)
            
            let tableViewVC = ZETableViewController(style: UITableViewStyle.Plain)
            // tableView顶部流出HeaderView和MenuView的位置
            tableViewVC.tableView.contentInset = UIEdgeInsetsMake(kScrollHorizY, 0, 0, 0 )
            tableViewVC.delegate = self
            tableViewVC.view.frame = CGRectMake(floatI * kZEScreenWidth,0, self.view.frame.size.width, kZEScreenHight)
            tableViewVC.tags = titlesArr[i]
            
            // 将tableViewVC添加进数组方便管理
            tableViewArr.append(tableViewVC)
            self.addChildViewController(tableViewVC)
        }
        // 需要用到的时候再添加到view上,避免一上来就占用太多资源
        backgroundScrollView?.addSubview(tableViewArr[0].view)
        self.view.addSubview(backgroundScrollView!)
    }
    /** 创建HeaderView和MenuView */
    func layoutHeaderMenuView(){
        // 通过Xib导入headerView
        headerView = NSBundle.mainBundle().loadNibNamed("ZEHeaderView", owner: self, options: nil).first as! ZEHeaderView
        headerView.frame = CGRectMake(0, 0, kZEScreenWidth, kZEHeaderHight)
        self.view.addSubview(headerView)
        
        // MenuView
        menuView = ZEMenuView(frame:CGRectMake(0,CGRectGetMaxY(headerView.frame),kZEScreenWidth,kZEMenuHight))
        menuView.delegate = self
        menuView.setUIWithArr(titlesArr)
        self.view.addSubview(self.menuView)
    }
    /** 因为频繁用到header和menu的固定,所以声明一个方法用于偷懒 */
    func headerMenuViewShowType(showType:headerMenuShowType){
        switch showType {
        case .up:
            menuView.frame.origin.y = kNavigationHight
            headerView.frame.origin.y = -kZEHeaderHight+64
            break
        case .buttom:
            headerView.frame.origin.y = 0
            menuView.frame.origin.y = CGRectGetMaxY(headerView.frame)
            break
        }
    }
    
    // MARK:DELEGATE
    func tableViewDidScrollPassY(tableviewScrollY: CGFloat) {
        // 计算每次改变的值
        let seleoffSetY = tableviewScrollY - scrollY
        // 将scrollY的值同步
        scrollY = tableviewScrollY
        print(scrollY)
        // 偏移量超出Navigation之上
        if scrollY >= -kZEMenuHight-kNavigationHight {
            self.navigationController?.navigationBar.hidden = false
            headerMenuViewShowType(.up)
        }else if  scrollY <= -kScrollHorizY {
            self.navigationController?.navigationBar.hidden = true
            // 偏移量超出Navigation之下
            headerMenuViewShowType(.buttom)
        }else{
            // 剩下的只有需要跟随的情况了
            // 将headerView的y值按照偏移量更改
            headerView.frame.origin.y -= seleoffSetY
            menuView.frame.origin.y = CGRectGetMaxY(headerView.frame)
        }
        
    }
    func menuViewSelectIndex(index: Int) {
        // 0.3秒的动画为了显得不太突兀
        UIView.animateWithDuration(0.3) {
            self.backgroundScrollView?.contentOffset = CGPointMake(kZEScreenWidth*CGFloat(index),-kNavigationHight)
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 判断是否有X变动,这里只处理横向滑动
        if scrollX == scrollView.contentOffset.x{
            return;
        }
        // 当tableview滑动到很靠上的时候,下一个tableview出现时只用在menuView之下
        if scrollY >= -kZEMenuHight-kNavigationHight {
            scrollY = -kZEMenuHight-kNavigationHight
        }
        
        for tableViewVC in tableViewArr {
            tableViewVC.tableView.contentOffset = CGPointMake(0, scrollY)
        }
        
        // 用于改变menuView的状态
        let rate = (scrollView.contentOffset.x/kZEScreenWidth)
        self.menuView.scrollToRate(rate)
        
        // +0.7的意思是 当滑动到30%的时候加载下一个tableView
        backgroundScrollView?.addSubview(tableViewArr[Int(rate+0.7)].view)
        
        // 记录x
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
