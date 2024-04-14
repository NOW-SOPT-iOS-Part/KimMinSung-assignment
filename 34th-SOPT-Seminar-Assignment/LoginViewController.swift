//
//  LoginViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/13.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "아이디",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 3
        textField.backgroundColor = .darkGray
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "비밀번호", 
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 3
        textField.backgroundColor = .darkGray
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: UIControl.State.normal)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = CGColor(gray: 0.5, alpha: 1)
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: UIControl.Event.touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.configureHierachy()
        self.setLayout()
    }
    
    
    private func configureHierachy() {
        [self.titleLabel,
         self.idTextField,
         self.passwordTextField,
         self.loginButton
        ].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func setLayout() {
        [self.titleLabel,
         self.idTextField,
         self.passwordTextField,
         self.loginButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.titleLabel.snp.makeConstraints { label in
            label.centerX.equalToSuperview()
            label.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(90)
            //label.leading.equalToSuperview().offset(16)
            //label.trailing.equalToSuperview().offset(-16)
        }
        
        self.idTextField.snp.makeConstraints { tf in
            tf.centerX.equalToSuperview()
            tf.top.equalTo(self.titleLabel.snp.bottom).offset(30)
            tf.leading.equalToSuperview().offset(20)
            tf.trailing.equalToSuperview().offset(-20)
            tf.height.equalTo(50)
        }
        
        self.passwordTextField.snp.makeConstraints { tf in
            tf.centerX.equalToSuperview()
            tf.top.equalTo(self.idTextField.snp.bottom).offset(10)
            tf.leading.equalToSuperview().offset(20)
            tf.trailing.equalToSuperview().offset(-20)
            tf.height.equalTo(52)
        }
        
        self.loginButton.snp.makeConstraints { btn in
            btn.centerX.equalToSuperview()
            btn.top.equalTo(self.passwordTextField.snp.bottom).offset(21)
            btn.leading.equalToSuperview().offset(16)
            btn.trailing.equalToSuperview().offset(-16)
            btn.height.equalTo(52)
        }
        
    }
    
    @objc func loginButtonDidTapped() {
        print(#function)
    }
    
    
    
    
    
}
