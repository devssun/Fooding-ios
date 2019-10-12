//
//  GradeView.swift
//  Fooding
//
//  Created by 최혜선 on 06/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

public enum Grade: String {
    case first = "1등급"
    case second = "2등급"
    case third = "3등급"
    case other = ""
    
    var value: String {
        return rawValue
    }
}

class ProductGradeView: UIView {    
    private let containerView: UIView = {
       let lv = UIView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.backgroundColor = .white
        lv.clipsToBounds = true
        lv.layer.masksToBounds = false
        return lv
    }()
    
    private let gradeLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.adjustsFontSizeToFitWidth = true
        lb.textAlignment = .center
        lb.font = UIFont.boldSystemFont(ofSize: 20.0)
        return lb
    }()
    
    var grade: Grade = .other {
        didSet {
            gradeLabel.text = grade.value
            switch grade {
            case .first:
                containerView.backgroundColor = .pomegranate
                gradeLabel.textColor = .white
            case .second:
                containerView.backgroundColor = .pumpkin
                gradeLabel.textColor = .white
            case .third:
                containerView.backgroundColor = .orange
                gradeLabel.textColor = .white
            case .other:
                containerView.backgroundColor = .lightGrey
                gradeLabel.textColor = .black
                gradeLabel.text = "등급없음"
            }
        }
    }
    
    private func commonInit() {
        self.addSubview(containerView)
        self.addSubview(gradeLabel)
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradeLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        gradeLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 5.0).isActive = true
        gradeLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -5.0).isActive = true
        gradeLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
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
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        containerView.layer.cornerRadius = containerView.frame.width / 2
    }
}
