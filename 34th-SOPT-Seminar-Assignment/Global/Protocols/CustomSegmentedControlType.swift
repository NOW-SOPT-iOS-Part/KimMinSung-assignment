//
//  CustomSegmentedControlType.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/07.
//

import UIKit

// 프로토콜을 생성하긴 했는데, 추상화를 통한 DI 는 구현하지 못함. (생각보다 복잡한 것 같아서 추후 구현 시도해볼 예정)
protocol CustomSegmentedControlType: AnyObject {
    
    associatedtype ConcreteType: UIView
    
    init(titles: [String], viewModel: HomeTabViewModel)
    
    var underbarLeadingConstraint: NSLayoutConstraint { get set }
    var underbarTrailingConstraint: NSLayoutConstraint { get set }
    
    var underbar: UIView { get }
    var separator: UIView { get }
    
    func updateSegmentState(selectedIndex: Int)
    func setUnderbarPosition(at: Int)
    
}



extension CustomSegmentedControlType where Self: UIStackView {
    
    /// SegmentStackView의 상태를 변경하는 함수
    /// - Parameter selectedIndex: 선택할 인덱스
    func updateSegmentState(selectedIndex: Int) {
        //선택함 버튼의 폰트만 굵게 설정
        self.arrangedSubviews.forEach { view in
            let button = view as! UIButton
            button.isSelected = button.tag == selectedIndex
        }
        
        // 언더바 위치 설정하는 애니메이션 설정
        let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
        animator.addAnimations { [unowned self] in
            self.setUnderbarPosition(at: selectedIndex)
        }
        animator.startAnimation()
    }
    
    /// 언더바 constraints 위치를 특정  index에 맞게 설정
    /// - Parameter index: underbar가 위치할 index
    func setUnderbarPosition(at index: Int) {
        guard let selectedButton = self.arrangedSubviews[index] as? UIButton else { fatalError() }
        guard let buttonLabel = selectedButton.titleLabel else { return }
        let buttonLabelFrame = selectedButton.convert(buttonLabel.frame, to: self)
        self.underbarLeadingConstraint.constant = buttonLabelFrame.origin.x
        self.underbarTrailingConstraint.constant = buttonLabelFrame.origin.x + buttonLabel.bounds.width
        self.layoutIfNeeded() // 애니메이션 구현하기 위함
    }
    
}
