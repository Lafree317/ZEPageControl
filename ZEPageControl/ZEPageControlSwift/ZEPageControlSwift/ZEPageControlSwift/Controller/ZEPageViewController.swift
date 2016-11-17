// 掘金:http://gold.xitu.io/#/user/567bbee434f81a1d8790bd0c
// 简书"http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317

import UIKit

class ZEPageViewController: UIViewController,UIScrollViewDelegate,ZETableViewControllerDelegate,ZEMenuViewDelegate {
    
    var tableViewArr:Array<ZETableViewController> = []// 存放tableView
    
    var backgroundScrollView:UIScrollView?// 底部scrollView
    var menuView:ZEMenuView!// 菜单
    var headerView:ZEHeaderView!// 展示个人属性的view
    var topView:ZETopView!// 假TitleView
    
    var titlesArr:Array<String>!// 存放菜单的内容
    var scrollY:CGFloat = 0// 记录当偏移量
    var scrollX:CGFloat = 0// 记录当偏移量
    var navigaionTitle: String? // title
    var topBar:UINavigationBar!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // didAppear隐藏,不会让整个页面向上移动64
        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        navigaionTitle = "轩辕小羽"
        self.automaticallyAdjustsScrollViewInsets = false
        layoutBackgroundScrollView()
        layoutHeaderMenuView()
        layoutTopView()
        hiddenNav(true)
    }

    /** 创建底部scrollView,并将tableViewController添加到上面 */
    func layoutBackgroundScrollView(){
        // 需要创建到高度0上,所以backgroundScrollView.y要等于-64
        self.backgroundScrollView = UIScrollView(frame:CGRect(x: 0,y: -kNavigationHight,width: kZEScreenWidth,height: kZEScreenHight+kNavigationHight))
        self.backgroundScrollView?.isPagingEnabled = true
        self.backgroundScrollView?.bounces = false
        self.backgroundScrollView?.delegate = self
        let floatArrCount = CGFloat(titlesArr.count)
        self.backgroundScrollView?.contentSize = CGSize(width: floatArrCount*kZEScreenWidth,height: self.view.frame.size.height-kNavigationHight)
        
        // 给scrollY赋初值避免一上来滑动就乱
        scrollY = -kScrollHorizY // tableView自己持有的偏移量和赋值时给的偏移量符号是相反的
        for  i in 0 ..< titlesArr.count  {
            let floatI = CGFloat(i)
            
            let tableViewVC = ZETableViewController(style: UITableViewStyle.plain)
            // tableView顶部流出HeaderView和MenuView的位置
            tableViewVC.tableView.contentInset = UIEdgeInsetsMake(kScrollHorizY, 0, 0, 0 )
            tableViewVC.delegate = self
            tableViewVC.view.frame = CGRect(x: floatI * kZEScreenWidth,y: 0, width: self.view.frame.size.width, height: kZEScreenHight)
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
        headerView = Bundle.main.loadNibNamed("ZEHeaderView", owner: self, options: nil)?.first as! ZEHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: kZEScreenWidth, height: kZEHeaderHight)
        self.view.addSubview(headerView)
        
        // MenuView
        menuView = ZEMenuView(frame:CGRect(x: 0,y: headerView.frame.maxY,width: kZEScreenWidth,height: kZEMenuHight))
        menuView.delegate = self
        menuView.setUIWithArr(titlesArr)
        self.view.addSubview(self.menuView)
    }
    // 搭建假NAvigation...
    func layoutTopView(){
        // 创建假Title
        topView = Bundle.main.loadNibNamed("ZETopView", owner: self, options: nil)?.first as! ZETopView
        topView.frame = CGRect(x: 0,y: 0, width: kZEScreenWidth, height: kNavigationHight)
        self.view.addSubview(topView)
        
        // 给title赋值..我也不知道为什么突然只能用这种方式赋值了,需要研究一下
        self.navigationController?.navigationBar.topItem?.title = navigaionTitle
        // 给假的title赋值
        topView.titleLabel.text = navigaionTitle
        
        
    }
    /** 因为频繁用到header和menu的固定,所以声明一个方法用于偷懒 */
    func headerMenuViewShowType(_ showType:headerMenuShowType){
        switch showType {
        case .up:
            menuView.frame.origin.y = kNavigationHight
            headerView.frame.origin.y = -kZEHeaderHight+64
            self.navigationController?.navigationBar.alpha = 1
            hiddenNav(false)
            
            break
        case .buttom:
            headerView.frame.origin.y = 0
            menuView.frame.origin.y = headerView.frame.maxY
            self.navigationController?.navigationBar.alpha = 0
            hiddenNav(true)
            break
        }
    }
    
    // MARK:DELEGATE
    func tableViewDidScrollPassY(_ tableviewScrollY: CGFloat) {
        // 计算每次改变的值
        let seleoffSetY = tableviewScrollY - scrollY
        // 将scrollY的值同步
        scrollY = tableviewScrollY
        
        // 偏移量超出Navigation之上
        if scrollY >= -kZEMenuHight-kNavigationHight {
            headerMenuViewShowType(.up)
        }else if  scrollY <= -kScrollHorizY {
            // 偏移量超出Navigation之下
            headerMenuViewShowType(.buttom)
        }else{
            // 剩下的只有需要跟随的情况了
            // 将headerView的y值按照偏移量更改
            headerView.frame.origin.y -= seleoffSetY
            menuView.frame.origin.y = headerView.frame.maxY
            // 基准线 用于当做计算0-1的..被除数..分母...
            let datumLine = -kZEMenuHight-kNavigationHight + kScrollHorizY
            // 计算当前的值..除数...分子..
            let nowY = scrollY + kZEMenuHight+kNavigationHight
            // 一个0-1的值
            let nowAlpa = 1+nowY/datumLine
            
            // 以0.5为基础 改变字体和状态栏的颜色
            if nowAlpa > 0.5 {
                hiddenNav(false)
            }else{
                hiddenNav(true)
                
            }
            self.navigationController?.navigationBar.alpha = nowAlpa
        }
        
    }
    func menuViewSelectIndex(_ index: Int) {
        // 0.3秒的动画为了显得不太突兀
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundScrollView?.contentOffset = CGPoint(x: kZEScreenWidth*CGFloat(index),y: -kNavigationHight)
        }) 
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 判断是否有X变动,这里只处理横向滑动
        if scrollX == scrollView.contentOffset.x{
            return;
        }
        // 当tableview滑动到很靠上的时候,下一个tableview出现时只用在menuView之下
        if scrollY >= -kZEMenuHight-kNavigationHight {
            scrollY = -kZEMenuHight-kNavigationHight
        }
        
        for tableViewVC in tableViewArr {
            tableViewVC.tableView.contentOffset = CGPoint(x: 0, y: scrollY)
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
    

    
    func hiddenNav(_ hidden:Bool){
        
        if hidden {
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        }else{
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
             UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }
    }

}
