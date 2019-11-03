//
//  TestFailureListTableViewCell.swift
//  Fooding
//
//  Created by 최혜선 on 2019/11/03.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class TestFailureListTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var productNameLabel: UILabel!
    @IBOutlet fileprivate weak var companyNameLabel: UILabel!
    @IBOutlet fileprivate weak var failureStandardItemNameLabel: UILabel!
    @IBOutlet fileprivate weak var standardScoreLabel: UILabel!
    
    var item: TestFailureRow? {
        didSet {
            productNameLabel.text = item?.prdtnm
            companyNameLabel.text = item?.bsshnm
            failureStandardItemNameLabel.text = item?.testItmnm
            standardScoreLabel.text = item?.score
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .lightGrey
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 10.0
        self.failureStandardItemNameLabel.textColor = .pomegranate
        self.standardScoreLabel.textColor = .pomegranate
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productNameLabel.text = nil
        companyNameLabel.text = nil
        failureStandardItemNameLabel.text = nil
        standardScoreLabel.text = nil
    }
}
