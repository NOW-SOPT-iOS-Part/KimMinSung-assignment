//
//  SegmentStackButton.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/07.
//

import UIKit

import RxSwift
import RxCocoa

final class SegmentStackButton: UIButton {
    
    //버튼 선택 시 폰트를 굵게 설정
    override var isSelected: Bool {
        didSet {
            let weight: CGFloat = self.isSelected ? 600 : 400
            self.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: weight)
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 400)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, tag: Int) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.tag = tag
    }
    
}
