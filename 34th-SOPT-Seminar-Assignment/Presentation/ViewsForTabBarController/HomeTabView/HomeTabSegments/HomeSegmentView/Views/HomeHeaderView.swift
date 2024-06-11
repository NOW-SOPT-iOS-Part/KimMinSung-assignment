//
//  HomeCollectionViewHeaderView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit


final class HomeHeaderView: UICollectionReusableView, ReusableViewType {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 15, weight: 600)
        label.textColor = .white
        return label
    }()
    
    // viewAllButton font는...?
    private let viewAllButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("전체보기", for: .normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 11, weight: 500)
        button.tintColor = .gray2
        button.setTitleColor(.gray2, for: .normal)
        button.setTitleColor(.gray3, for: .highlighted)
        button.setImage(UIImage(systemName: "chevron.right"), for: UIControl.State.normal)
        button.semanticContentAttribute = .forceRightToLeft // 버튼 안의 > 모양 이미지를 버튼 안쪽에서 오른쪽에 위치시키기 위함
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 3, bottom: 4, right: 0)
        
        /*
         아래와 같이 configuration으로 도 구현할까 생각해 보았는데,
         configuration은 세세한 크기를 조정하는 데에 한계가 있는 것 같아 보였습니다...!(제가 틀렸을 수도)
         그래서 우선 위와 같은 방법으로 구현하였는데,imageEdgeInsets 속성이 deprecated되었다고 노란색 경고(?)가 뜨네요...
         (구현은 되고, 문제도 없는데 은근 찝찝함)
         혹시 다른 방법으로 해결하신 분이 있을까요~?
         */
        
//        let transformer = UIConfigurationTextAttributesTransformer { incoming in
//            var outgoing = incoming
//            outgoing.font = UIFont.pretendardFont(ofSize: 11, weight: 500)
//            outgoing.foregroundColor = .black
//            return outgoing
//        }
//
//        var btnConfig = UIButton.Configuration.plain()
//        btnConfig.titleTextAttributesTransformer = transformer
//        btnConfig.imagePlacement = .trailing
//        btnConfig.baseForegroundColor = .gray2
//        btnConfig.title = "전체보기"
//        btnConfig.buttonSize = .mini
//        btnConfig.imagePadding = 3
//        btnConfig.image = UIImage(systemName: "chevron.right")
//        btnConfig.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 0, bottom: 7, trailing: 0)
//        let button = UIButton(configuration: btnConfig)
//        button.imageView?.contentMode = .scaleAspectFill
//        //button.setImage(UIImage(systemName: "chevron.right"), for: UIControl.State.normal)
//        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 3, bottom: 4, right: 0)
        
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
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            //make.height.equalTo(20)
        }
    }
    
    func withHeaderTitle(_ labelText: String) -> HomeHeaderView {
        self.headerLabel.text = labelText
        return self
    }
    


}
