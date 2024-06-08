//
//  HomeTabView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/08.
//

import UIKit

import SnapKit

final class HomeTabView: UIView {
    
    // segmentStackView.topAnchor의 constraint는 스크롤함에 따라 constatn 값을 바꿔주기 위해 별도의 상수로 정의
    lazy var segmentStackViewTopConstraint = self.segmentStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0)
    
    let segmentStackView: SegmentStackView = SegmentStackView(titles: ["홈", "실시간", "TV프로그램", "영화", "파라마운트"])
    
    let naviBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let pageVC: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewHierarchy() {
        
        // 베열 순서 주의!
        [self.pageVC.view, self.naviBackView, self.segmentStackView].forEach { view in
            self.addSubview(view)
        }
    }
    
    
    private func setConstraints() {
        self.naviBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.segmentStackView)
        }
        
        self.pageVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.segmentStackViewTopConstraint.isActive = true
        self.segmentStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(56)
        }
        //self.segmentStackView.setAutoLayout()
    }
    
}
