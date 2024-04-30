//
//  HomeVerticalRectCell.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/27.
//

import UIKit

class HomeVerticalRectCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.layer.cornerCurve = .continuous
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 500)
        label.textAlignment = .left
        label.textColor = .gray2
        label.numberOfLines = 2
        label.text = "해리포터와 마법사의 돌"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setAutoLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewHierarchy() {
        [self.posterImageView, self.titleLabel].forEach { self.contentView.addSubview($0) }
    }
    
    private func setAutoLayout() {
        self.posterImageView.snp.makeConstraints { imgView in
            imgView.top.leading.trailing.equalToSuperview()
            imgView.height.equalTo(146)
        }
        
        self.titleLabel.snp.makeConstraints { label in
            label.top.equalTo(self.posterImageView.snp.bottom).offset(3)
            label.horizontalEdges.equalToSuperview()
            //label.height.equalTo(17)
        }
    }
    
    func configureData(with content: ContentProtocol) {
        self.posterImageView.image = content.image
        self.titleLabel.text = content.name
    }
    
}
