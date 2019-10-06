//
//  ViewController.swift
//  Fooding
//
//  Created by 최혜선 on 05/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class BarcodeScanViewController: UIViewController {
    
    @IBOutlet fileprivate weak var barcodeScanView: BarcodeScannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        barcodeScanView.delegate = self
        self.view.backgroundColor = .lightGrey
    }
}

extension BarcodeScanViewController: BarcodeScannerViewDelegate {
    func detectBarcode(detectString: String) {
        print("발견된 바코드 \(detectString)")
    }
}
