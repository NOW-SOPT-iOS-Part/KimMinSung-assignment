//
//  InitialViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/13.
//

import UIKit
import SnapKit

class InitialViewController: UIViewController {
    
    let mainImageView: UIImageView = {
        let kboImage = UIImage(named: "initialImage.kbo")
        let imageView = UIImageView(image: kboImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("티빙 로그인", for: UIControl.State.normal)
        button.backgroundColor = UIColor(named: "TVING_Red")
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.configureHierarchy()
        self.setLayout()
    }
    
    
    private func configureHierarchy() {
        [self.mainImageView, self.loginButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func setLayout() {
        [self.mainImageView, self.loginButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.mainImageView.snp.makeConstraints { imgView in
            imgView.top.equalToSuperview()
            imgView.leading.equalToSuperview()
            imgView.trailing.equalToSuperview()
            imgView.bottom.equalToSuperview()
        }
        
        self.loginButton.snp.makeConstraints { btn in
            btn.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
            btn.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            btn.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-27)
            btn.height.equalTo(52)
        }
    }
    
    
    
    @objc private func loginButtonDidTapped() {
        //let loginVC = LoginViewController()
        //loginVC.modalPresentationStyle = .fullScreen
        //self.present(loginVC, animated: true)
        
        // 편의상 임시로 로그인버튼 누를 시 mainTabBarCon이 present 되도록 설정...
        let mainTabBarCon = UITabBarController.getMainTabBarCon()
        mainTabBarCon.modalPresentationStyle = .fullScreen
        self.present(mainTabBarCon, animated: true)
    }

}
