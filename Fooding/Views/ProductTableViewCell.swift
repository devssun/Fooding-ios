//
//  ProductTableViewCell.swift
//  Fooding
//
//  Created by 최혜선 on 06/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var productImageView: UIImageView!
    @IBOutlet fileprivate weak var productNameLabel: UILabel!
    @IBOutlet fileprivate weak var productRecallLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .lightGrey
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 10.0
        self.productImageView.clipsToBounds = true
        self.productImageView.contentMode = .scaleAspectFill
        self.productImageView.layer.cornerRadius = 10.0
    }
}
