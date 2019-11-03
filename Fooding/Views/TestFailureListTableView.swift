//
//  TestFailureListTableView.swift
//  Fooding
//
//  Created by 최혜선 on 2019/11/03.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class TestFailureListTableView: UITableView {
    
    var items = [TestFailureRow]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        self.dataSource = self
        self.backgroundColor = .lightGrey
        self.separatorStyle = .none
        self.tableFooterView = UIView(frame: .zero)
        self.rowHeight = 160.0
        self.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension TestFailureListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "failCell", for: indexPath) as? TestFailureListTableViewCell {
            cell.selectionStyle = .none
            cell.item = items[indexPath.row]
            return cell
        }
        
        fatalError("failure cell error")
    }
}
