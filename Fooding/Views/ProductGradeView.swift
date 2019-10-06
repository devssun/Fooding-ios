//
//  GradeView.swift
//  Fooding
//
//  Created by 최혜선 on 06/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class ProductGradeView: UIView {
    
    private let containerView: UIView = {
       let lv = UIView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.backgroundColor = .lightGrey
        lv.clipsToBounds = true
        lv.layer.masksToBounds = false
        return lv
    }()
    
    private let gradeLabel: UILabel = {
       let lb = UILabel()
        lb.text = "1급"
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 24.0)
        return lb
    }()
    
    private func commonInit() {
        self.addSubview(containerView)
        self.addSubview(gradeLabel)
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        gradeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        containerView.layer.cornerRadius = containerView.frame.width / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
