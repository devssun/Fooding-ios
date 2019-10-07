//
//  ProductDetailViewController.swift
//  Fooding
//
//  Created by 최혜선 on 06/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet fileprivate weak var productImageView: UIImageView!
    @IBOutlet fileprivate weak var productRecallLabel: UILabel!
    @IBOutlet fileprivate weak var actionDateLabel: UILabel!
    @IBOutlet fileprivate weak var productGradeView: ProductGradeView!
    @IBOutlet fileprivate weak var productionDateLabel: UILabel!
    @IBOutlet fileprivate weak var expirationDateLabel: UILabel!
    @IBOutlet fileprivate weak var packingUnitLabel: UILabel!
    @IBOutlet fileprivate weak var productCategoryLabel: UILabel!
    @IBOutlet fileprivate weak var companyNameLabel: UILabel!
    @IBOutlet fileprivate weak var companyAddressLabel: UILabel!
    @IBOutlet fileprivate weak var companyContactLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .lightGrey
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "제품명"
        self.productImageView.contentMode = .scaleAspectFill
    }
}
