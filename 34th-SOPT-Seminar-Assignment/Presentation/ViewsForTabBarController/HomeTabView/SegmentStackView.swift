//
//  SegmentStackView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class SegmentStackView: UIStackView, CustomSegmentedControlType {
    
    typealias ConcreteType = SegmentStackView
    
    var viewModel: HomeTabViewModel!
    var currentIndex: Int { self.viewModel.currentIndex }
    
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
    
    lazy var underbarLeadingConstraint = self.underbar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    lazy var underbarTrailingConstraint = self.underbar.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    
    convenience init(titles: [String], viewModel: HomeTabViewModel) {
        
        guard Set(titles).count == titles.count else { fatalError() } //titles 배열에 중복되는 이름이 있는 지 확인
        let buttonsArray = titles.map({ SegmentStackButton(title: $0, tag: titles.firstIndex(of: $0)!) })
//        self.init(frame: .zero)
        self.init(arrangedSubviews: buttonsArray)
        self.viewModel = viewModel
        
        self.setStackViewLayout()
        self.configureViewHierarchy()
        self.setConstraints()
        self.subscribeButtons()
        
    }
    
    private func setStackViewLayout() {
        self.axis = .horizontal
        self.distribution = .fillProportionally
        self.spacing = 5
    }
    
    private func configureViewHierarchy() {
        self.addSubviews(self.separator, self.underbar)
    }
    
    private func setConstraints() {
        self.separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        self.underbarLeadingConstraint.isActive = true
        self.underbarTrailingConstraint.isActive = true
        self.underbar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        self.underbar.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    private func subscribeButtons() {
        self.arrangedSubviews.forEach { view in
            let button = view as! UIButton
            button.rx.tap.subscribe(onNext: { [unowned self] in
                button.isSelected.toggle()
                var isForward: UIPageViewController.NavigationDirection {
                    return (self.currentIndex <= button.tag) ? .forward : .reverse
                }
                //pageViewController 스와이프 동작
                self.viewModel.pageVC.setViewControllers([self.viewModel.vcArray[button.tag]], direction: isForward, animated: true)
                self.updateSegmentState(selectedIndex: button.tag)
            }).disposed(by: self.viewModel.disposeBag)
        }
    }
    
}
