// 简书:http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317/ZEPageControl

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

