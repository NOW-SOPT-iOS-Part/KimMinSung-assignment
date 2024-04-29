//
//  HomePosterViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

class HomePosterViewController: UIViewController {
    
    let posterImageView: UIImageView = {
        //let imageView = UIImageView(image: .init(systemName: "home"))
        let imageView = UIImageView(image: .posterDocuOurGame)
        imageView.backgroundColor = .systemGray3
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 14, weight: 400)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .white
        label.text = """
        [7화 공개🔔] 28년만의 우승을 노린다!
        2022년 LG트윈스의 피, 땀, 눈물 그 모든 이야기
        """
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
    
    
    
}
