//
//  ParentViewController.swift
//  Fooding
//
//  Created by 최혜선 on 2019/10/31.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ParentViewController: ButtonBarPagerTabStripViewController {
    @IBOutlet fileprivate weak var customerDeclarationButton: UIBarButtonItem!
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    fileprivate var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        // change selected bar color
        self.view.backgroundColor = .lightGrey
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.searchController = searchController
       
        self.definesPresentationContext = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.5
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
        
        customerDeclarationButton.target = self
        customerDeclarationButton.action = #selector(touchedCustomerDeclarationButton(_:))
        super.viewDidLoad()
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
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child1")
        let child2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        return [child1, child2]
    }
}

extension ParentViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
//        if searchController.isActive {
//            let fileteredData = dataItems.filter({ (data: Row) -> Bool in
//                return data.prdtnm.contains(searchController.searchBar.text!.lowercased())
//            })
//
//            self.filteredItems = fileteredData
//            DispatchQueue.main.async {
//                self.productTableView.items = fileteredData
//                self.productTableView.reloadData()
//            }
//        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        DispatchQueue.main.async {
//            self.productTableView.items = self.dataItems
//            self.productTableView.reloadData()
//        }
    }
}
