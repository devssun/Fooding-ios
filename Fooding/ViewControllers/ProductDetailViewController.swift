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
    
    var item: Row?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .lightGrey
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = item?.prdtnm
        self.productImageView.contentMode = .scaleAspectFill
        self.productRecallLabel.textColor = .pomegranate
        
        self.productImageView.isUserInteractionEnabled = true
        self.productImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchedProductImageView(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productImageView.image = UIImage(data: item!.imageData)
        productRecallLabel.text = item?.rtrvlprvns
        actionDateLabel.text = item?.cretDtm
        productGradeView.grade = Grade(rawValue: item!.rtrvlGrdcdNm)!
        productionDateLabel.text = item?.mnfdt
        expirationDateLabel.text = item?.distbtmlmt
        packingUnitLabel.text = item?.frmlcunit
        productCategoryLabel.text = item?.prdlstType
        companyNameLabel.text = item?.bsshnm
        companyAddressLabel.text = item?.addr
        companyContactLabel.text = item?.prcscitypointTelno
    }
    
    @objc private func touchedProductImageView(_ gesture: UITapGestureRecognizer) {
        let imageDetailViewController = ImageDetailViewController(nibName: nil, bundle: nil)
        imageDetailViewController.imageData = item!.imageData
        self.navigationController?.pushViewController(imageDetailViewController, animated: true)
    }
}
