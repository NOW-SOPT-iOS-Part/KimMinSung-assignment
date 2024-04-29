//
//  SegmentStackView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

class SegmentStackView: UIStackView {
    
    var currentIndex: Int = 0
    
    let underbar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setAutoLayout()
    }
    
    private lazy var underbarLeadingConstraint = self.underbar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    private lazy var underbarTrailingConstraint = self.underbar.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        [self.separator, self.underbar].forEach { self.addSubview($0) }
    }
    
    func setAutoLayout() {
        
        self.separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        self.underbarLeadingConstraint.isActive = true
        self.underbarTrailingConstraint.isActive = true
        self.underbar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        self.underbar.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    func select(at index: Int) {
        let buttonCount = self.arrangedSubviews.count
        guard buttonCount > 0 else { return }
        for i in 0..<buttonCount {
            guard let button = self.arrangedSubviews[i] as? UIButton else { return }
            button.isSelected = i == index ? true : false
            button.titleLabel?.font = button.isSelected ? UIFont.pretendardFont(ofSize: 17, weight: 600) : UIFont.pretendardFont(ofSize: 17, weight: 400)
        }
        self.currentIndex = index
        
        // 언더바 위치 설정하는 애니메이션 설정
        let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
        animator.addAnimations {
            self.setUnderbarHorizontalLayout(to: index)
        }
        animator.startAnimation()
    }
    
    
    func setUnderbarHorizontalLayout(to index: Int) {
        guard let selectedButton = self.arrangedSubviews[index] as? UIButton else { fatalError() }
        guard let buttonLabel = selectedButton.titleLabel else { return }
        let buttonLabelFrame = selectedButton.convert(buttonLabel.frame, to: self)
        self.underbarLeadingConstraint.constant = buttonLabelFrame.origin.x
        self.underbarTrailingConstraint.constant = buttonLabelFrame.origin.x + buttonLabel.bounds.width
        self.layoutIfNeeded()
    }
    
}


extension SegmentStackView {
    
    static func getDefault() -> SegmentStackView {
        
        let segmentButton0: UIButton = {
            let button = UIButton()
            button.setTitle("홈", for: .normal)
            button.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 400)
            button.tag = 0
            return button
        }()
        
        let segmentButton1: UIButton = {
            let button = UIButton()
            button.setTitle("실시간", for: .normal)
            button.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 400)
            button.tag = 1
            return button
        }()
        
        let segmentButton2: UIButton = {
            let button = UIButton()
            button.setTitle("TV프로그램", for: .normal)
            button.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 400)
            button.tag = 2
            return button
        }()
        
        let segmentButton3: UIButton = {
            let button = UIButton()
            button.setTitle("영화", for: .normal)
            button.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 400)
            button.tag = 3
            return button
        }()
        
        let segmentButton4: UIButton = {
            let button = UIButton()
            button.setTitle("파라마운트+", for: .normal)
            button.titleLabel?.font = UIFont.pretendardFont(ofSize: 17, weight: 400)
            button.tag = 4
            return button
        }()
        
        let stackView = SegmentStackView(
            arrangedSubviews: [
                segmentButton0,
                segmentButton1,
                segmentButton2,
                segmentButton3,
                segmentButton4
            ]
        )
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
        
    }
    
}
