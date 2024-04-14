//
//  InitialViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/13.
//

import UIKit
import SnapKit

class InitialViewController: UIViewController {

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("티빙 로그인", for: UIControl.State.normal)
        button.backgroundColor = .systemRed
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
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
        self.view.addSubview(loginButton)
    }
    
    private func setLayout() {
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.snp.makeConstraints { btn in
            btn.leading.equalToSuperview().offset(16)
            btn.trailing.equalToSuperview().offset(-16)
            btn.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-27)
            btn.height.equalTo(52)
        }
    }
    
    
    
    @objc private func loginButtonDidTapped() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }

}
