//
//  HomePosterPagingCell.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

class HomePosterPagingCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let vcArray: [UIViewController] = {
        let vc1 = HomePosterViewController()
        let vc2 = HomePosterViewController()
        let vc3 = HomePosterViewController()
        let vc4 = HomePosterViewController()
        let vc5 = HomePosterViewController()
        let vc6 = HomePosterViewController()
        let vc7 = HomePosterViewController()
        let vc8 = HomePosterViewController()
        return [vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8]
    }()
    
    let pagingVC: UIPageViewController = {
        let pagingVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pagingVC.view.isUserInteractionEnabled = true
        return pagingVC
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 8
        pageControl.currentPage = 0
        return pageControl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setAutoLayout()
        self.setPageVC()
        self.setPageControl()
        self.setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        [self.pagingVC.view, self.pageControl].forEach { self.contentView.addSubview($0) }
    }
    
    private func setAutoLayout() {
        self.pagingVC.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.current.bounds.width * 1.5)
        }
        //self.pagingVC.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        self.pageControl.snp.makeConstraints { make in
            make.top.equalTo(self.pagingVC.view.snp.bottom)
            make.leading.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        self.pageControl.setContentCompressionResistancePriority(.init(999), for: .vertical)
    }
    
    private func setPageVC() {
        self.pagingVC.setViewControllers([self.vcArray[0]], direction: .forward, animated: true)
        self.pagingVC.view.isUserInteractionEnabled = true
    }
    
    private func setPageControl() {
        self.pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: UIControl.Event.valueChanged)
        // pageControl의 크기 조정
        let pageControlSize = self.pageControl.intrinsicContentSize
        print("width: ", self.pageControl.intrinsicContentSize.width)
        print("height: ", self.pageControl.intrinsicContentSize.height)
        
        let shrinkTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translateTransform = CGAffineTransform(translationX: -pageControlSize.width * 0.25, y: -pageControlSize.height * 0.25)
        
        self.pageControl.transform = shrinkTransform.concatenating(translateTransform)
    }
    
    private func setDelegates() {
        self.pagingVC.dataSource = self
        self.pagingVC.delegate = self
    }
    
    @objc private func pageControlValueChanged(sender: UIPageControl) {
        let oldIndex = self.vcArray.firstIndex(of: self.pagingVC.viewControllers![0])!
        let newIndex = sender.currentPage
        print("oldIndex: ", oldIndex)
        print("newIndex: ", newIndex)
        
        if oldIndex < newIndex {
            self.pagingVC.setViewControllers([self.vcArray[sender.currentPage]], direction: .forward, animated: true)
        } else {
            self.pagingVC.setViewControllers([self.vcArray[sender.currentPage]], direction: .reverse, animated: true)
        }
        
    }
    
}

extension HomePosterPagingCell: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.vcArray.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 { return nil }
        return self.vcArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.vcArray.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex >= self.vcArray.count { return nil }
        return self.vcArray[nextIndex]
    }
    
}

extension HomePosterPagingCell: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            let newIndex = self.vcArray.firstIndex(of: pageViewController.viewControllers![0])!
            self.pageControl.currentPage = newIndex
        }
    }
}
