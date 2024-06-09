//
//  Tab0ViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class HomeTabViewController: UIViewController {
    
    //인스턴스 속성
    let rootView: HomeTabView!
    let viewModel: HomeTabViewModel
    
    /*
     커스텀한 상단의 세그먼트 컨트롤을 구체적인 타입인 SegmentStackView 타입이 아닌
     CustomSegmentedControlType이라는 (프로토콜로 추상화된) 타입으로 정의하였고, 외부에서 생성자를 통해 주입하는 방법으로 구현하였다.
     이를 통해 DIP를 준수함으로써 결합도를 낮추었다.
     만약, 상단의 세그먼트가 많아져 UIStackView가 아닌, UICollectionView 등으로 구현해야 할 경우에도
     해당 (커스텀)세그먼트 컨트롤 타입이 CustomSegmentedControlType 프로토콜을 채택하기만 하면
     HomeTabViewController의 코드 변경을 최소화할 수 있다. -> OCP(개방-폐쇄 원칙)
     */
    var segmentedControl: any CustomSegmentedControlType// = self.rootView.segmentStackView
    
    //viewModel로부터 가져오는 데이터들
    var vcArray: [UIViewController] { self.viewModel.vcArray }
    var pageVC: UIPageViewController { self.viewModel.pageVC }
    var currentIndex: Int { self.viewModel.currentIndex }
    
    //HomeTabViewController에서 사용할 UI Component들 (rootView에서 가져옴)
    lazy var segmentStackViewTopConstraint = self.rootView.segmentStackViewTopConstraint
    lazy var naviBackView = self.rootView.naviBarBackView
    
    //MARK: RxSwift
    var disposeBag: DisposeBag { self.viewModel.disposeBag }
    
    init(viewModel: HomeTabViewModel, segmentedControl: any CustomSegmentedControlType) {
        self.rootView = HomeTabView(viewModel: viewModel, segmentedControl: segmentedControl)
        self.viewModel = viewModel
        self.segmentedControl = segmentedControl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDelegates()
        self.setNaviBar()
        self.subscribeScrollView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //상단 segmentStackView의 언더바 초기 위치를 설정하기 위해서 호출.
        self.segmentedControl.updateSegmentState(selectedIndex: self.currentIndex)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        guard let homeVC = self.vcArray[0] as? HomeViewController else { fatalError() }
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: self.view.safeAreaInsets.bottom, right: 0)
        homeVC.rootView.setCollectionViewContentInset(inset: inset)
    }
    
    private func setDelegates() {
        self.pageVC.dataSource = self
        self.pageVC.delegate = self
    }
    
    private func setNaviBar() {
        
        self.navigationController?.navigationBar.tintColor = .white
        
        let logoButton: UIButton = {
            let button = UIButton(type: .system) // type을 system으로 한 것은 navigationBar의 tintColor가 적용되게 하기 위함.
            button.setImage(.tvingLogoLetter, for: .normal)
            button.snp.makeConstraints { make in
                make.width.equalTo(99)
                make.height.equalTo(25)
            }
            return button
        }()
        
        let profileButton: UIButton = { [weak self] in
            guard let self else { return UIButton() }
            let button = UIButton(type: .custom)
            button.setImage(.profileImageAsset, for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.clipsToBounds = true
            button.layer.cornerRadius = 7
            button.layer.cornerCurve = .continuous
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 32).isActive = true
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            button.addTarget(self, action: #selector(profileButtonDidTapped), for: .touchUpInside)
            return button
        }()
        
        let logoBarButtonItem = UIBarButtonItem(customView: logoButton)
        let airplayBarButtonItem = UIBarButtonItem(
            image: .init(systemName: "airplayvideo"),
            style: .plain,
            target: self,
            action: #selector(airPlayBarButtonDidTapped)
        )
        let profileBarButtonItem = UIBarButtonItem(customView: profileButton)
        
        self.navigationItem.leftBarButtonItem = logoBarButtonItem
        self.navigationItem.setRightBarButtonItems([profileBarButtonItem, airplayBarButtonItem], animated: false)
        
    }
    
    private func subscribeScrollView() {
        guard let homeVC = self.vcArray[0] as? HomeViewController else { fatalError() }
        let homeCollectionView = homeVC.rootView.collectionView
        
        homeCollectionView.rx.didScroll
            .subscribe(onNext: { self.scrollViewDidScroll(homeCollectionView) })
            .disposed(by: self.disposeBag)
    }
    
    /// HomeViewController에 있는 컬렉션 뷰를 아래로 스크롤 시에 상단 SegmentStackView의 위치를 조정
    /// - Parameter scrollView: scroll view
    ///
    /// 기존 UIScrollViewDelegate에서 호출하는 함수와 동일한 역할. (RxSwift와 RxCocoa로 구현한 것 뿐...)
    /// HomeViewController의 컬렉션 뷰를 스크롤할 때마다 상단 Segment Stack View를 Sticky하게 설정
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let naviBarHeight = self.navigationController?.navigationBar.bounds.height ?? 0.0
        let yOffset = scrollView.contentOffset.y
        if yOffset > 0 {
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
            self.navigationController?.navigationBar.bounds.origin.y = yOffset
            self.naviBackView.backgroundColor = .black.withAlphaComponent(min(yOffset / naviBarHeight, 1))
            self.segmentedControl.separator.backgroundColor = .gray4.withAlphaComponent(min(yOffset / naviBarHeight, 1))
            self.segmentStackViewTopConstraint.constant = -min(yOffset, naviBarHeight)
        } else {
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.navigationController?.navigationBar.backgroundColor = .black.withAlphaComponent(0)
            self.navigationController?.navigationBar.bounds.origin.y = 0
            self.naviBackView.backgroundColor = .clear
            self.segmentedControl.separator.backgroundColor = .clear
            self.segmentStackViewTopConstraint.constant = 0
        }
    }
    
    @objc private func profileButtonDidTapped() {
        self.navigationController?.pushViewController(ProfileSettingsViewController(), animated: true)
    }
    
    @objc func airPlayBarButtonDidTapped() {
        print(#function)
    }
}


//MARK: - UIPageVieControllerDataSource
extension HomeTabViewController: UIPageViewControllerDataSource {
    
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


//MARK: - UIPageViewControllerDelegate
extension HomeTabViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let index = self.vcArray.firstIndex(of: self.pageVC.viewControllers![0])!
        //self.selectSegmentButton(index: index)
        self.segmentedControl.updateSegmentState(selectedIndex: index)
    }
    
}
