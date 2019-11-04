//
//  ListViewController.swift
//  Fooding
//
//  Created by 최혜선 on 05/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecallProductListViewController: UIViewController {
    
    @IBOutlet fileprivate weak var productTableView: ProductTableView!
    fileprivate var dataItems = [Row]()
    fileprivate var filteredItems = [Row]()
    
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
    fileprivate var startIndex: Int = 1
    fileprivate var endIndex: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        commonInit()
        indicator.startAnimating()
        requestProductList(.recall)
    }
    
    @objc func didReceiveProductList(_ noti: Notification) {
        guard let data = noti.userInfo?["data"] as? Recall else {
            return
        }
        
        dataItems += data.i0490.row
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.refreshControl.endRefreshing()
            self.productTableView.isLoadMore = false
            self.productTableView.items += data.i0490.row
            self.productTableView.reloadData()
        }
    }
    
    @objc private func refreshTableView() {
        requestProductList(.recall)
    }
    
    private func commonInit() {
        self.view.backgroundColor = .lightGrey
        
        productTableView.productDelegate = self
        productTableView.refreshControl = refreshControl
        
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.view.addSubview(indicator)
        indicator.center = self.view.center
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProductList(_:)), name: DidReceiveProductList, object: nil)
    }
}

extension RecallProductListViewController: ProductTableViewDelegate {
    func selectProduct(_ index: Int) {
        if let productDetailViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
//            productDetailViewController.item = searchController.isActive ? filteredItems[index] : dataItems[index]
            productDetailViewController.item = dataItems[index]
           self.navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
    
    func loadMoreProducts() {
        // load
        print("loadMoreProducts startIdx \(startIndex) endIdx \(endIndex)")
        startIndex = endIndex + 1
        endIndex += 20
        print("end startIdx \(startIndex) endIdx \(endIndex)")
        indicator.startAnimating()
        requestProductList(.recall, startIdx: startIndex, endIndex: endIndex)
    }
}

extension RecallProductListViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "회수﹒판매중지")
    }
}
