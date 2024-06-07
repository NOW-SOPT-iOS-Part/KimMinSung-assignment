//
//  HomeLiveContentCell.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/10.
//

import UIKit
import SnapKit

class HomeLiveContentCell: HomeRankingContentCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        
        self.posterImageView.snp.makeConstraints { imgView in
            imgView.top.leading.trailing.equalToSuperview()
            imgView.width.equalTo(160)
            imgView.height.equalTo(80)
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
        }
    }
    
}
