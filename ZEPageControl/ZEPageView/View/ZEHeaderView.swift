// 简书:http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317/ZEPageControl

import UIKit



class ZEHeaderView: UIView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var goldButton: UIButton!
    
    @IBOutlet weak var jianshuButton: UIButton!
    
    @IBOutlet weak var githubButton: UIButton!
    
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
