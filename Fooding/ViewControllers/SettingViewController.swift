//
//  SettingViewController.swift
//  Fooding
//
//  Created by 최혜선 on 2019/10/17.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet fileprivate weak var settingTableView: SettingTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingTableView.selectDelegate = self
    }
}

extension SettingViewController: SettingTableViewDelegate {
    func selectItem(_ index: Int) {
        
    }
}
