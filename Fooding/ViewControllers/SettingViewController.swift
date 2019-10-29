//
//  SettingViewController.swift
//  Fooding
//
//  Created by 최혜선 on 2019/10/17.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit
import MessageUI

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
        let composeVC = MFMailComposeViewController()
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["chocochic85@gmail.com"])
        composeVC.setSubject("[Fooding] 앱 문의!")
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
}
