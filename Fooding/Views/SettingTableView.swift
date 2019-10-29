//
//  SettingTableView.swift
//  Fooding
//
//  Created by 최혜선 on 2019/10/17.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

protocol SettingTableViewDelegate: class {
    func selectItem(_ index: Int)
}

class SettingTableView: UITableView {
    weak var selectDelegate: SettingTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = .lightGrey
        self.tableFooterView = UIView(frame: .zero)
    }
}

extension SettingTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "개발자에게 문의하기"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDelegate?.selectItem(indexPath.row)
    }
}
