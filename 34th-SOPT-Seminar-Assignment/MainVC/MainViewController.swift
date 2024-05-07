//
//  Tab0ViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

class MainViewController: UIViewController {
    
    // segmentStackView.topAnchor의 constraint는 스크롤함에 따라 constatn 값을 바꿔주기 위해 별도의 상수로 정의
    lazy var segmentStackViewTopConstraint = self.segmentStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)

    let segmentStackView: SegmentStackView = SegmentStackView.getDefault()
    let vcArray = [HomeViewController(), LiveViewController(), TVProgramViewController(), MovieViewController(), ParamountPlusViewController()]
    let pageVC: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    // 스크롤 시 navigation bar 부분의 배경을 어둡게 하기 위해 UIView()를 배치하였음.
    let naviBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewHierarchy()
        self.setAutoLayout()
        self.setPageVC()
        self.setDelegates()
        self.setButtonsAction()
        self.setNaviBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
         상단 segmentStackView의 언더비 초기 위치를 설정하기 위해서 호출.
         setUnderbarHorizontalLayout 함수가 각 버튼(의 titleLabel)의 frame에 접근하는데, 아마 그것 때문인지
         view가 그려지기 전에는 해당 함수를 호출해도 언더바가 맞게 그려지지 않더라구요..(viewWillAppear에서도 안됐음...
         viewDidAppear에 그려지는 것이 약간 찜찜한데(약간의 시간차가 있음), 혹시 더 좋은 위치가 있으면 그곳에서 호출하면 좋을 것 같음!
         */
        guard let currentIndex =  self.vcArray.firstIndex(of: self.pageVC.viewControllers![0]) else { return }
        
        self.segmentStackView.setUnderbarHorizontalLayout(to: currentIndex)
    }
    
    private func configureViewHierarchy() {
        
        // 베열 순서 주의!
        [self.pageVC.view, self.naviBackView, self.segmentStackView].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func setAutoLayout() {
        
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
        self.segmentStackView.setAutoLayout()
    }
    
    private func setPageVC() {
        self.pageVC.setViewControllers([self.vcArray[0]], direction: .forward, animated: false)
    }
    
    private func setDelegates() {
        self.pageVC.dataSource = self
        self.pageVC.delegate = self
        
        guard let homeVC = self.vcArray[0] as? HomeViewController else { fatalError() }
        homeVC.rootView.collectionView.delegate = self
    }
    
    private func setButtonsAction() {
        self.segmentStackView.arrangedSubviews.forEach { view in
            guard let button = view as? UIButton else { return }
            button.addTarget(self, action: #selector(segmentButtonDidTapped(sender:)), for: .touchUpInside)
        }
    }
    
    @objc private func segmentButtonDidTapped(sender: UIButton) {
        var isForward: UIPageViewController.NavigationDirection {
            let currentIndex = self.vcArray.firstIndex(of: self.pageVC.viewControllers![0])!
            if currentIndex <= sender.tag {
                return .forward
            } else {
                return .reverse
            }
        }
        
        switch sender.tag {
        case 0:
            self.pageVC.setViewControllers([self.vcArray[0]], direction: isForward, animated: true)
        case 1:
            self.pageVC.setViewControllers([self.vcArray[1]], direction: isForward, animated: true)
        case 2:
            self.pageVC.setViewControllers([self.vcArray[2]], direction: isForward, animated: true)
        case 3:
            self.pageVC.setViewControllers([self.vcArray[3]], direction: isForward, animated: true)
        case 4:
            self.pageVC.setViewControllers([self.vcArray[4]], direction: isForward, animated: true)
        default:
            return
        }
        
        self.segmentStackView.select(at: sender.tag)
        
    }
    
    
    private func setNaviBar() {
        
        self.navigationController?.navigationBar.tintColor = .white
        
        let logoButton: UIButton = {
            let button = UIButton(type: .system) // type을 system으로 한 것은 navigationBar의 tintColor가 적용되게 하기 위함.
            button.setImage(.tvingLogoLetter, for: .normal)
            /*
             navigation bar의 왼쪽에 들어갈 로고의 크기 조절
             UIBarButtonItem의 customView로 UIButton 인스턴스를 넣고,
             해당 UIButton의 인스턴스에 NSLayoutConstraint를 적용하여 오토레이아웃 적용하였음.
             *혹시 더 좋은 코드가 있다면 알려주세요~
             */
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 99).isActive = true
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.isUserInteractionEnabled = false
            return button
        }()
        
        let profileButton: UIButton = { [ weak self] in
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
    
    @objc private func profileButtonDidTapped() {
        // ProfileSettingViewController는 미완...
        self.navigationController?.pushViewController(ProfileSettingsViewController(), animated: true)
    }
    
    @objc func airPlayBarButtonDidTapped() {
        print(#function)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        guard let homeVC = self.vcArray[0] as? HomeViewController else { fatalError() }
        print(self.view.safeAreaInsets.bottom)
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: self.view.safeAreaInsets.bottom, right: 0)
        homeVC.rootView.setCollectionViewContentInset(inset: inset)
    }
}


extension MainViewController: UIPageViewControllerDataSource {
    
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

extension MainViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let index = self.vcArray.firstIndex(of: self.pageVC.viewControllers![0])!
        //self.selectSegmentButton(index: index)
        self.segmentStackView.select(at: index)
    }
    
}


extension MainViewController: UICollectionViewDelegate {
    
    
    // 해당 함수가 호출될 때마다 self.segmentStackView와 navigation bar의 위치를 조정하여, stick한 뷰를 구현
    // 오토레이아웃을 사용했기 때문에, frame에 직접 값을 할당하는 것 보다는 NSLayoutConstraint의 constant에 값을 할당하는 방식으로 구현
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let naviBarHeight = self.navigationController?.navigationBar.bounds.height ?? 0.0
        let yOffset = scrollView.contentOffset.y
        if yOffset > 0 {
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
            self.navigationController?.navigationBar.bounds.origin.y = yOffset
            self.naviBackView.backgroundColor = .black.withAlphaComponent(yOffset / naviBarHeight)
            self.segmentStackView.separator.backgroundColor = .gray4.withAlphaComponent(yOffset / naviBarHeight)
            self.segmentStackViewTopConstraint.constant = -yOffset
            if yOffset > naviBarHeight {
                self.naviBackView.backgroundColor = .black
                self.segmentStackView.separator.backgroundColor = .gray4
                self.segmentStackViewTopConstraint.constant = -naviBarHeight
            }
            
        } else {
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.navigationController?.navigationBar.backgroundColor = .black.withAlphaComponent(0)
            self.navigationController?.navigationBar.bounds.origin.y = 0
            self.naviBackView.backgroundColor = .clear
            self.segmentStackView.separator.backgroundColor = .clear
            self.segmentStackViewTopConstraint.constant = 0
        }
    }
    
}
