//
//  HomeCollectionViewHeaderView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit


final class HomeHeaderView: UICollectionReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 15, weight: 600)
        label.textColor = .white
        label.text = "티빙에서 꼭 봐야하는 콘텐츠"
        return label
    }()
    
    // viewAllButton font는...?
    private let viewAllButton: UIButton = {
        //var btnConfig = UIButton.Configuration.plain()
        //btnConfig.imagePlacement = .trailing
        //btnConfig.baseForegroundColor = .gray2
        //btnConfig.title = "전체보기"
        //btnConfig.buttonSize = .mini
        //btnConfig.imagePadding = 5
        //btnConfig.image = UIImage(systemName: "chevron.right")
        //let button = UIButton(configuration: btnConfig)
        
        let button = UIButton()
        button.setTitle("전체보기", for: .normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 11, weight: 500)
        button.tintColor = .gray2
        button.setTitleColor(.gray2, for: .normal)
        button.setTitleColor(.gray3, for: .highlighted)
        button.setImage(UIImage(systemName: "chevron.right"), for: UIControl.State.normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 3, bottom: 4, right: 0)
        
        return button
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
        [self.headerLabel, self.viewAllButton].forEach { self.addSubview($0) }
    }
    
    private func setAutoLayout() {
        self.headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.viewAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func withHeaderTitle(_ labelText: String) -> HomeHeaderView {
        self.headerLabel.text = labelText
        return self
    }
    


}
