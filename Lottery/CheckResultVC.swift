//
//  CheckResultVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/7/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class CheckResultVC: BaseViewController,UIScrollViewDelegate {

    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var scrlView: UIScrollView!
    override func viewDidLayoutSubviews() {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
    }
    @IBOutlet weak var pageControl: UIPageControl!{
        didSet{
            pageControl.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    @IBAction func btnCheckClick(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isResultSeen")
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultDetailVC") as! ResultDetailVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
}


