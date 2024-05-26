//
//  ParamountPlusViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

class ParamountPlusViewController: UIViewController {

    let imageView: UIImageView = {
        let imageView = UIImageView(image: .paramountPlus)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewHierarchy()
        self.setupAutoLayout()
    }
    
    private func setupViewHierarchy() {
        self.view.addSubview(self.imageView)
    }
    
    private func setupAutoLayout() {
        self.imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
}
