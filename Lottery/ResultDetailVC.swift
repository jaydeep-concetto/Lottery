//
//  ResultDetailVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/7/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
class ResultDetailCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
}
class ResultDetailVC: BaseViewController {

   
    @IBOutlet var seperator1: UIButton!
    @IBOutlet var seperator2: UIButton!
   
    @IBOutlet var tblView1: UITableView!
    @IBOutlet var tblView2: UITableView!
    @IBOutlet var scrlView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        seperator1.isHidden = false
        seperator2.isHidden = true
      
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
    }
    @IBAction func btnSegment1Click(_ sender: Any) {
        seperator1.isHidden = false
        seperator2.isHidden = true
        self.scrlView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    @IBAction func btnSegment2Click(_ sender: Any) {
        seperator1.isHidden = true
        seperator2.isHidden = false
        self.scrlView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: true)
    }
    
    @IBAction func btnCloseClick(_ sender: UIButton){
        let b = self.tabBarController?.viewControllers![0] as! UINavigationController
        b.popToRootViewController(animated: false)
        self.tabBarController?.selectedIndex = 0
    }

}
//MARK: UITableView Delegates and Datasource
extension ResultDetailVC: UITableViewDataSource, UITableViewDelegate{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultDetailCell", for: indexPath) as! ResultDetailCell    
       SVSetValue(SV: cell.stackView)
        return cell
    }
    
   
}
