// 掘金:http://gold.xitu.io/#/user/567bbee434f81a1d8790bd0c
// 简书"http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317

import UIKit


protocol ZETableViewControllerDelegate{
    func tableViewDidScrollPassY(_ tableviewScrollY:CGFloat)
}

class ZETableViewController: UITableViewController {
    
    var delegate:ZETableViewControllerDelegate?
    var tags:String!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(tags+"WillAppear")
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.register(UINib.init(nibName: "ZECell", bundle: nil), forCellReuseIdentifier: "ZECell")
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.tableViewDidScrollPassY(scrollView.contentOffset.y)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZECell", for: indexPath) as! ZECell

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
