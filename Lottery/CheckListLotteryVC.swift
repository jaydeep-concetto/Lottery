//
//  CheckResultVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/7/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class CheckListLotteryVC: BaseViewController,UIScrollViewDelegate {
    
    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var scrlView: UIScrollView!
    override func viewDidLayoutSubviews() {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!{
        didSet{
            pageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnAllowHelpClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btnCheckClick(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isListLotterySeen")
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "LotteryPreview1VC") as! LotteryPreview1VC
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
    }
}

