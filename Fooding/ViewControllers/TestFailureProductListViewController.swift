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
    
    fileprivate let indicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.color = .black
        ai.hidesWhenStopped = true
        return ai
    }()
    fileprivate let refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return rc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        self.indicator.startAnimating()
        requestProductList(.nonconformity)
    }
    
    @objc private func refreshTableView() {
        requestProductList(.nonconformity)
    }
    
    @objc func didReceiveProductList(_ noti: Notification) {
        guard let data = noti.userInfo?["data"] as? TestFailure else {
            return
        }
        
        dataItems += data.i2620.row
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.refreshControl.endRefreshing()
            self.testFailureListTableView.items += data.i2620.row
            self.testFailureListTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func commonInit() {
        self.view.backgroundColor = .lightGrey
        testFailureListTableView.refreshControl = refreshControl
        
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.view.addSubview(indicator)
        indicator.center = self.view.center
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProductList(_:)), name: DidReceiveProductList, object: nil)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "검사부적합")
    }
}
