//
//  HomeLiveContentCell.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/27.
//

enum RankingCellImageRatio {
    case horizontal
    case vertical
}


import UIKit
import SnapKit

class HomeRankingContentCell: UICollectionViewCell {
    
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rankingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 15, weight: 800)
        label.textColor = .white
        label.transform = CGAffineTransform(1.0, 0.0, -0.3, 1.0, 0.0, 0.0)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textAlignment = .left
        label.textColor = .gray2
        return label
    }()
    
    let percentageNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textColor = .gray2
        return label
    }()
    
    
    lazy var imageViewWidthConstraint = self.posterImageView.widthAnchor.constraint(equalToConstant: 0)
    lazy var imageViewHeightConstraint = self.posterImageView.heightAnchor.constraint(equalToConstant: 0)
    lazy var percentageNumberLabelBottomConstraint = self.percentageNumberLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setAutoLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewHierarchy() {
        self.contentView.clipsToBounds = true
        [self.posterImageView,
         self.rankingLabel,
         self.mainTitleLabel,
         self.subTitleLabel,
         self.percentageNumberLabel
        ].forEach { self.contentView.addSubview($0) }
    }
    
    private func setAutoLayout() {
        
        self.imageViewWidthConstraint.isActive = true
        self.imageViewHeightConstraint.isActive = true
        self.posterImageView.snp.makeConstraints { imgView in
            imgView.top.leading.trailing.equalToSuperview()
        }
        
        self.rankingLabel.snp.makeConstraints { make in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(6)
        }
        
        self.mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(11)
            make.leading.equalTo(self.rankingLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(5)
        }
        
        self.subTitleLabel.snp.makeConstraints { label in
            label.top.equalTo(self.mainTitleLabel.snp.bottom)
            label.leading.equalTo(self.mainTitleLabel)
            label.trailing.equalToSuperview().inset(5)
        }
        
        self.percentageNumberLabelBottomConstraint.isActive = true
        self.percentageNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(self.subTitleLabel.snp.bottom)
            make.leading.equalTo(self.mainTitleLabel)
            make.trailing.equalToSuperview().inset(5)
            //make.bottom.equalToSuperview()
        }
    }
    
    
    func configureData(with content: ContentProtocol) {
        self.posterImageView.image = content.image
        self.subTitleLabel.text = content.name
        
        guard let liveContent = content as? LiveContentProtocol else { return }
        //liveContent.updateImage()
        if let ranking = liveContent.ranking {
            self.rankingLabel.text = "\(ranking)"
        }
        
        self.mainTitleLabel.text = liveContent.channelName
        self.percentageNumberLabel.text = String(format: "%.1f%%", liveContent.ratings)
        self.posterImageView.image = liveContent.image
    }
    
    func setImageRatio(to ratio: RankingCellImageRatio) {
        switch ratio {
        case .horizontal:
            self.posterImageView.snp.makeConstraints { imgView in
                self.imageViewWidthConstraint.constant = 160
                self.imageViewHeightConstraint.constant = 80
                self.percentageNumberLabelBottomConstraint.isActive = false
            }
            
        case .vertical:
            self.posterImageView.snp.makeConstraints { imgView in
                self.imageViewWidthConstraint.constant = 98
                self.imageViewHeightConstraint.constant = 146
                self.percentageNumberLabelBottomConstraint.isActive = true
            }
        }
    }
    
}
