//
//  HomeLiveContentCell.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/27.
//

//enum RankingCellImageRatio {
//    case horizontal
//    case vertical
//}


import UIKit

class HomeRankingContentCell: UICollectionViewCell, RankingCellType {
    
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
        label.numberOfLines = 2
        return label
    }()
    
    let metricLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 10, weight: 400)
        label.textColor = .gray2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
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
         self.metricLabel]
            .forEach { self.contentView.addSubview($0) }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.posterImageView.backgroundColor = .lightGray
        self.rankingLabel.text = ""
        self.mainTitleLabel.text = ""
        self.subTitleLabel.text = ""
        self.metricLabel.text = ""
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
        self.metricLabel.text = String(format: "%.1f%%", liveContent.ratings)
        self.posterImageView.image = liveContent.image
    }
    
}
