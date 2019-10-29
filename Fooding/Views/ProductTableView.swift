//
//  ProductTableView.swift
//  Fooding
//
//  Created by 최혜선 on 06/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

protocol ProductTableViewDelegate: class {
    func selectProduct(_ index: Int)
    func loadMoreProducts()
}

class ProductTableView: UITableView {
    weak var productDelegate: ProductTableViewDelegate?
    var items = [Row]()
    var isLoadMore: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    private func commonInit() {
        self.delegate = self
        self.dataSource = self
        self.rowHeight = 130.0
        self.estimatedRowHeight = UITableView.automaticDimension
        self.backgroundColor = .lightGrey
    }
}

extension ProductTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell {
            cell.selectionStyle = .none
            cell.item = items[indexPath.row]
            return cell
        }
        
        fatalError("Cell Error")
    }
}

extension ProductTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productDelegate?.selectProduct(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isLoadMore && indexPath.row == (items.count - 1) {
            print("load more \(indexPath.row)")
            isLoadMore = true
            productDelegate?.loadMoreProducts()
        }
    }
}
