//
//  ImageDetailViewController.swift
//  Fooding
//
//  Created by 최혜선 on 2019/10/20.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    fileprivate let scrollView: UIScrollView = {
       let sc = UIScrollView()
        sc.alwaysBounceVertical = false
        sc.alwaysBounceHorizontal = false
        sc.minimumZoomScale = 1.0
        sc.maximumZoomScale = 2.0
        return sc
    }()
    fileprivate let imageView = UIImageView()
    var imageData: Data! {
        didSet {
            imageView.image = UIImage(data: imageData)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        
        self.navigationItem.largeTitleDisplayMode = .never
    }
}

extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
