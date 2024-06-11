//
//  HomeBoxOfficeCell.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/10.
//

import UIKit
import SnapKit

/*
 랭킹을 나타내는 Cell을 HomeBoxOfficeCell과 HomeLiveContentCell로 분리함.
 HomeBoxOfficeCell은 날짜별 박스오피스를 보여주면서 reload할 일이 많은데, 이때, 동적으로 셀의 크기를 지정하다 보니 스크롤이 부자연스럽게 끊기는 현상이 있었음.
 그래서 AutoLayout Constraint를 제외한 기본 뼈대를 구상하는 HomeRankingContentCell을 만들고, 정적으로 AutoLayout Constraint를 정해 주는 함수를 자식 클래스에 구현하여 추가함.
 -> 스크롤이 부자연스럽게 끊기는 현상 해결!
 다만, HomeRankingContentCell을 추상화하고 싶어서 프로토콜과 확장으로 구현해도 좋을 것 같았는데, 시간이 없어서 못함(양해 바랍니다...ㅠㅅㅠ)
 */
class HomeBoxOfficeCell: HomeRankingContentCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        self.posterImageView.snp.makeConstraints { imgView in
            imgView.top.leading.trailing.equalToSuperview()
            imgView.width.equalTo(98)
            imgView.height.equalTo(146)
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
        
        self.metricLabel.snp.makeConstraints { make in
            make.top.equalTo(self.subTitleLabel.snp.bottom)
            make.leading.equalTo(self.mainTitleLabel)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
    }
    
    
    func configureData(with content: BoxOfficeMovieProtocol) {
        self.rankingLabel.text = "\(content.ranking)"
        self.mainTitleLabel.text = content.movieName
        self.posterImageView.image = content.image
        let formattedAudienceAccumulated = content.audienceAccumulated.formatted(.number)
        self.subTitleLabel.text = "누적관객수:\n\(formattedAudienceAccumulated)명"
    }
    
}
