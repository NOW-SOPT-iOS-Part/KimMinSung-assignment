//
//  HomeTabView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/08.
//

import UIKit

import SnapKit

final class HomeTabView: UIView {
    
    /*
     HomeViewController로부터 전달받은 segmentedControl에는 CustomSegmentedControlType을 준수하는 모든 타입이 올 수 있다.
     HomeTableView 타입에서는 뷰의 레이아웃과 관련된 역할만 하기 때문에,
     UI 컴포넌트로서의 역할을 수행하기 위해 클래스 UIView 타입으로 정의하였음.
     */
    var segmentedControl: UIView
    var viewModel: HomeTabViewModel!
    
    let naviBarBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let pageVC: UIPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    // segmentStackView.topAnchor의 constraint는 스크롤함에 따라 constatn 값을 바꿔주기 위해 별도의 상수로 정의
    lazy var segmentStackViewTopConstraint = self.segmentedControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0)
    
    init(viewModel: HomeTabViewModel, segmentedControl: any CustomSegmentedControlType) {
        guard let segmentStackView = segmentedControl as? SegmentStackView else { fatalError() }
        self.viewModel = viewModel
        self.segmentedControl = segmentStackView
        super.init(frame: .zero)
        
        self.configureViewHierarchy()
        self.setConstraints()
        self.bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        
        // 베열 순서 주의!
        [self.pageVC.view, self.naviBarBackView, self.segmentedControl].forEach { view in
            self.addSubview(view)
        }
    }
    
    
    private func setConstraints() {
        self.naviBarBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.segmentedControl)
        }
        
        self.pageVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.segmentStackViewTopConstraint.isActive = true
        self.segmentedControl.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(56)
        }
        //self.segmentStackView.setAutoLayout()
    }
    
    private func bindViewModel() {
        self.viewModel.pageVC = self.pageVC
    }
    
}
