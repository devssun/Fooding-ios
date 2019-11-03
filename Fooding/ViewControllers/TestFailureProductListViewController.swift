//
//  ChildViewController2.swift
//  Fooding
//
//  Created by 최혜선 on 2019/11/02.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TestFailureProductListViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet fileprivate weak var testFailureListTableView: TestFailureListTableView!
    fileprivate var dataItems = [TestFailureRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGrey
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProductList(_:)), name: DidReceiveProductList, object: nil)
        requestProductList(.nonconformity)
    }
    
    @objc func didReceiveProductList(_ noti: Notification) {
        guard let data = noti.userInfo?["data"] as? TestFailure else {
            return
        }
        
        dataItems += data.i2620.row
        DispatchQueue.main.async {
            self.testFailureListTableView.items += data.i2620.row
            self.testFailureListTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "검사부적합")
    }
}
