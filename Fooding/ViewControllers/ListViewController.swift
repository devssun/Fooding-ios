//
//  ListViewController.swift
//  Fooding
//
//  Created by 최혜선 on 05/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet fileprivate weak var customerDeclarationButton: UIBarButtonItem!
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
        customerDeclarationButton.target = self
        customerDeclarationButton.action = #selector(touchedCustomerDeclarationButton(_:))
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
    
    @objc private func touchedCustomerDeclarationButton(_ sender: UIBarButtonItem) {
        // 소비자 신고
        let alertController = UIAlertController(title: "소비자 신고", message: "구입한 식품에 이상이 있다면 아래에 신고하세요", preferredStyle: .actionSheet)
        let callAction = UIAlertAction(title: "식품안전 소비자 신고센터 1399", style: .default) { (_) in
            if let tel = URL(string: "tel://1399") {
                UIApplication.shared.open(tel, options: [:], completionHandler: nil)
            }
        }
        let webAction = UIAlertAction(title: "식품의약품안전처 통합민원상담서비스 홈페이지", style: .default) { (_) in
            if let url = URL(string: "https://www.foodsafetykorea.go.kr/minwon/complain/customerNotify.do?menu_no=621&menu_grp=MENU_GRP24") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(callAction)
        alertController.addAction(webAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
