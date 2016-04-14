// 掘金:http://gold.xitu.io/#/user/567bbee434f81a1d8790bd0c
// 简书"http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317

import UIKit



class ZEHeaderView: UIView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    

    @IBAction func buttonClick(sender: UIButton) {
        if sender.tag == 10086 {
            print("掘金:http://gold.xitu.io/#/user/567bbee434f81a1d8790bd0c")
        }else if sender.tag == 10087 {
            print("简书http://www.jianshu.com/p/1523c6bd3253")
        }else if sender.tag == 10088 {
            print("github:https://github.com/Lafree317")
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
