//
//  ScanResultPopupView.swift
//  Fooding
//
//  Created by 최혜선 on 2019/10/16.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

protocol ScanResultPopupViewDelegate: class {
    func touchedCloseButton()
}

class ScanResultPopupView: UIView {
    weak var delegate: ScanResultPopupViewDelegate?
    
    @IBOutlet fileprivate weak var productGradeView: ProductGradeView!
    @IBOutlet fileprivate weak var productNameLabel: UILabel!
    @IBOutlet fileprivate weak var productRecallReasonLabel: UILabel!
    @IBOutlet fileprivate weak var closeButton: UIButton!
    @IBOutlet weak var baseView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        closeButton.addTarget(self, action: #selector(touchedCloseButton(_:)), for: .touchUpInside)
    }
    
    @objc private func touchedCloseButton(_ sender: UIButton) {
        delegate?.touchedCloseButton()
    }
}
