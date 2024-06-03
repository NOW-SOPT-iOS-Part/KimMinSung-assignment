//
//  RankingCellType.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/03.
//

import UIKit

protocol RankingCellType: CellType {
    
    var posterImageView: UIImageView { get }
    
    var rankingLabel: UILabel { get }
    
    var mainTitleLabel: UILabel { get }
    
    var subTitleLabel: UILabel { get }
    
    var metricLabel: UILabel { get }
    
}
