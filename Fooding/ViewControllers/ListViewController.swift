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
    fileprivate var dataItems: Recall!
    fileprivate var filteredItems = [Row]()
    fileprivate var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .lightGrey
        self.definesPresentationContext = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        
        productTableView.selectDelegate = self
        
        requestProductList(.recall)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProductList(_:)), name: DidReceiveProductList, object: nil)
    }
    
    @objc func didReceiveProductList(_ noti: Notification) {
        guard let data = noti.userInfo?["data"] as? Recall else {
            return
        }
        
        dataItems = data
        DispatchQueue.main.async {
            self.productTableView.items = data.i0490.row
            self.productTableView.reloadData()
        }
    }
}

extension ListViewController: ProductTableViewDelegate {
    func selectProduct(_ index: Int) {
        if let productDetailViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            productDetailViewController.item = searchController.isActive ? filteredItems[index] : dataItems.i0490.row[index]
           self.navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
}

extension ListViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            guard dataItems != nil else { return }
            let fileteredData = dataItems.i0490.row.filter({ (data: Row) -> Bool in
                return data.prdtnm.contains(searchController.searchBar.text!.lowercased())
            })
            
            self.filteredItems = fileteredData
            DispatchQueue.main.async {
                self.productTableView.items = fileteredData
                self.productTableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.productTableView.items = self.dataItems.i0490.row
            self.productTableView.reloadData()
        }
    }
}
