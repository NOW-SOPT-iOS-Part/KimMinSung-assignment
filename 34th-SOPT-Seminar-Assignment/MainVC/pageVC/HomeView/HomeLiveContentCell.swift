//
//  HomeLiveContentCell.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/27.
//

import UIKit

class HomeLiveContentCell: UICollectionViewCell {
    
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
    
    let rankingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 15, weight: 800)
        label.textColor = .white
        label.transform = CGAffineTransform(1.0, 0.0, -0.3, 1.0, 0.0, 0.0)
        return label
    }()
    
    let channelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textAlignment = .left
        label.textColor = .gray2
        return label
    }()
    
    let ratingsNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textColor = .gray2
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
        [self.posterImageView,
         self.rankingLabel,
         self.channelNameLabel,
         self.titleLabel,
         self.ratingsNumberLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    private func setAutoLayout() {
        
        self.posterImageView.snp.makeConstraints { imgView in
            imgView.top.leading.trailing.equalToSuperview()
            imgView.height.equalTo(80)
        }
        
        self.rankingLabel.snp.makeConstraints { make in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(6)
        }
        
        self.channelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(11)
            make.leading.equalTo(self.rankingLabel.snp.trailing).offset(5)
        }
        
        self.titleLabel.snp.makeConstraints { label in
            label.top.equalTo(self.channelNameLabel.snp.bottom)
            label.leading.equalTo(self.channelNameLabel)
            //label.trailing.equalToSuperview()
        }
        
        self.ratingsNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leading.equalTo(self.channelNameLabel)
            //make.trailing.equalToSuperview()
        }
    }
    
    func configureData(with content: ContentProtocol) {
        self.posterImageView.image = content.image
        self.titleLabel.text = content.name
        
        guard var liveContent = content as? LiveContentProtocol else { return }
        //liveContent.updateImage()
        if let ranking = liveContent.ranking {
            self.rankingLabel.text = "\(ranking)"
        }
        
        self.channelNameLabel.text = liveContent.channelName
        self.ratingsNumberLabel.text = String(format: "%.1f%%", liveContent.ratings)
        self.posterImageView.image = liveContent.image
    }
    
}
