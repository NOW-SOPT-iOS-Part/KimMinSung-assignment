//
//  SegmentStackButton.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/07.
//

import UIKit

final class SegmentStackButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                self.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 600)
            case false:
                self.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 400)
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
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


let segmentButton0: UIButton = {
    let button = UIButton()
    button.setTitle("홈", for: .normal)
    button.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 400)
    button.tag = 0
    return button
}()
