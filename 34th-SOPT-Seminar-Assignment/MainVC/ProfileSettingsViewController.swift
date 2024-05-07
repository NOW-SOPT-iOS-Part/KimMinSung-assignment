//
//  ProfileSettingsViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/30.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: .profileSettingsViewTempImg)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewHierarchy()
        self.setupAutoLayout()
        self.setupNaviBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupViewHierarchy() {
        self.view.addSubview(self.imageView)
    }
    
    private func setupAutoLayout() {
        self.imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    
    /// navigation bar의 색을 systemOrange로 설정
    ///
    /// navigtion bar의 tintColor가 .white라서 상단 appearance를 다른 색으로 구현
    private func setupNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemOrange
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}
