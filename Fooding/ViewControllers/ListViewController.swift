//
//  ListViewController.swift
//  Fooding
//
//  Created by 최혜선 on 05/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet fileprivate weak var productTableView: ProductTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .lightGrey
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        productTableView.selectDelegate = self
        
        requestProductList(.recall)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProductList(_:)), name: DidReceiveProductList, object: nil)
    }
    
    @objc func didReceiveProductList(_ noti: Notification) {
        guard let data = noti.userInfo?["data"] as? Recall else {
            return
        }
        
        DispatchQueue.main.async {
            self.productTableView.items = data.i0490.row
            self.productTableView.reloadData()
        }
    }
}

extension ListViewController: ProductTableViewDelegate {
    func selectProduct() {
        if let productDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
           self.navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
}
