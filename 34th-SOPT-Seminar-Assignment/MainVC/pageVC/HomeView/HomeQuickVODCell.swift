//
//  HomeQuickVODCell.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/30.
//

import UIKit

class HomeQuickVODCell: UICollectionViewCell {
    
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textColor = .white
        label.text = "이름이 들어갈 자리입니다."
        return label
    }()
    
    let episodeNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textAlignment = .left
        label.textColor = .gray2
        label.text = "99화"
        return label
    }()
    
    //let ratingsNumberLabel: UILabel = {
    //    let label = UILabel()
    //    label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
    //    label.textColor = .gray2
    //    label.text = "80.0%"
    //    return label
    //}()
    
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
         //self.rankingLabel,
         self.nameLabel,
         self.episodeNumberLabel,
         //self.ratingsNumberLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    private func setAutoLayout() {
        
        self.posterImageView.snp.makeConstraints { imgView in
            imgView.top.leading.trailing.equalToSuperview()
            imgView.width.equalTo(150)
            imgView.height.equalTo(100)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(6)
        }
        
        self.episodeNumberLabel.snp.makeConstraints { label in
            label.top.equalTo(self.nameLabel.snp.bottom)
            label.leading.equalTo(self.nameLabel)
            //label.trailing.equalToSuperview()
        }
    }
    
    func configureData(with content: ContentProtocol) {
        self.posterImageView.image = content.image
        self.nameLabel.text = content.name
        self.episodeNumberLabel.text = "\(content.currentEpisode ?? 0)화 시청중"
    }
    
}
