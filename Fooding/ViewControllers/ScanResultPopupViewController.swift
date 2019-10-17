//
//  ScanResultPopupViewController.swift
//  Fooding
//
//  Created by 최혜선 on 2019/10/17.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class ScanResultPopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // register Xib
        guard let popup = UINib(nibName: "ScanResultPopupViewXib", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? ScanResultPopupView else {
            return
        }
        
        let viewColor = UIColor.black
        popup.backgroundColor = viewColor.withAlphaComponent(0.3)
        popup.frame = self.view.frame
        popup.baseView.clipsToBounds = true
        popup.baseView.layer.cornerRadius = 9.0
        popup.delegate = self
        self.view.addSubview(popup)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScanResultPopupViewController: ScanResultPopupViewDelegate {
    func touchedCloseButton() {
        self.dismiss(animated: false, completion: nil)
    }
}
