//
//  WelcomeViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/13.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    var nickname: String?
    var id: String
    
    let logoImgView: UIImageView = {
        let logoImage = UIImage(named: "tving.logo.box")
        let imageView = UIImageView(image: logoImage)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var welcomeMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.pretendardFont(ofSize: 23, weight: 700)
        label.text = "\(self.nickname ?? self.id)님\n반가워요!"
        label.numberOfLines = 2
        return label
    }()
    
    lazy var goToMainButton: UIButton = {
        let button = UIButton()
        button.setTitle("메인으로", for: UIControl.State.normal)
        button.backgroundColor = UIColor(named: "TVING_Red")
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(goToMainButtonDidTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    init(nickname: String? = nil, id: String) {
        self.nickname = nickname
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.configureHierarchy()
        self.setLayout()
    }
    
    private func configureHierarchy() {
        [self.logoImgView, self.welcomeMessageLabel, self.goToMainButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func setLayout() {
        [self.logoImgView, self.welcomeMessageLabel, self.goToMainButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.logoImgView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(58)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }
        
        self.welcomeMessageLabel.snp.makeConstraints { label in
            label.centerX.equalToSuperview()
            label.top.equalTo(self.logoImgView.snp.bottom).offset(67)
        }
        
        self.goToMainButton.snp.makeConstraints { button in
            button.centerX.equalToSuperview()
            button.leading.equalToSuperview().offset(20)
            button.trailing.equalToSuperview().offset(-20)
            button.bottom.equalToSuperview().offset(-66)
            button.height.equalTo(52)
        }
    }
    
    
    @objc private func goToMainButtonDidTapped() {
        print(#function)
        //self.dismiss(animated: true)
        let mainTabBarCon = UITabBarController.getMainTabBarCon()
        mainTabBarCon.modalPresentationStyle = .fullScreen
        self.present(mainTabBarCon, animated: true)
    }
    
}
