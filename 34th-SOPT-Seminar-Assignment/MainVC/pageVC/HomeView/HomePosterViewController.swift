//
//  HomePosterViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

class HomePosterViewController: UIViewController {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.backgroundColor = .systemGray3
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 14, weight: 400)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewHierarchy()
        self.setAutoLayout()
    }
    
    
    private func configureViewHierarchy(){
        [self.posterImageView, self.textLabel].forEach { self.view.addSubview($0) }
    }
    
    private func setAutoLayout() {
        self.posterImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        self.textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(17)
            make.bottom.equalToSuperview().offset(-17)
        }
    }
    
    func configureData(with content: ContentProtocol) {
        self.posterImageView.image = content.image
        self.textLabel.text = content.promotionalText
    }
    
}
