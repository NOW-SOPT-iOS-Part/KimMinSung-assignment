//
//  LoginView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/27.
//

import UIKit

import SnapKit

class LoginView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.font = UIFont.pretendardFont(ofSize: 23, weight: CGFloat(500))
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "아이디",
            attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.pretendardFont(ofSize: 15, weight: 600)]
        )
        textField.textColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        //textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.rightView = self.rightView1
        textField.leftViewMode = .always
        textField.rightViewMode = .whileEditing
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 3
        textField.layer.borderColor = UIColor(named: "gray2")?.cgColor
        textField.backgroundColor = UIColor(named: "gray4")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var pwTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "비밀번호",
            attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.pretendardFont(ofSize: 15, weight: 600)]
        )
        textField.textColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.rightView = self.rightView2
        textField.leftViewMode = .always
        textField.rightViewMode = .whileEditing
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 3
        textField.layer.borderColor = UIColor(named: "gray2")?.cgColor
        textField.backgroundColor = UIColor(named: "gray4")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var rightView1: UIView = {
        let view = UIView()
        //view.backgroundColor = .systemOrange
        return view
    }()
    
    lazy var rightView2: UIView = {
        let view = UIView()
        //view.backgroundColor = .systemOrange
        return view
    }()
    
    lazy var clearIDButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "x.circle"), for: UIControl.State.normal)
        button.setTitleColor(.lightGray, for: UIControl.State.normal)
        return button
    }()
    
    lazy var clearPWButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "x.circle"), for: UIControl.State.normal)
        button.setTitleColor(.lightGray, for: UIControl.State.normal)
        return button
    }()
    
    lazy var hidePWButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye.slash"), for: UIControl.State.selected)
        button.setImage(UIImage(named: "eye.filled"), for: UIControl.State.normal)
        button.isSelected = true
        return button
    }()
    
    let loginButton: TVINGLoginButton = TVINGLoginButton()
    
//    lazy var loginButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("로그인하기", for: UIControl.State.normal)
//        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
//        button.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.disabled)
//        button.setTitleColor(UIColor(named: "TVING_Red"), for: UIControl.State.normal)
//        button.backgroundColor = .clear
//        button.clipsToBounds = true
//        button.layer.cornerRadius = 3
//        button.layer.borderWidth = 0.5
//        button.layer.borderColor = CGColor(gray: 0.5, alpha: 1)
//        button.isEnabled = false
//        return button
//    }()
    
    lazy var findIDButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "gray3"), for: UIControl.State.highlighted)
        return button
    }()
    
    lazy var findPWButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "gray3"), for: UIControl.State.highlighted)
        return button
    }()
    
    lazy var makeAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("아직 계정이 없으신가요?", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.setTitleColor(UIColor(named: "gray3"), for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "gray4"), for: UIControl.State.highlighted)
        return button
    }()
    
    lazy var makeNicknameButton: UIButton = {
        let button = UIButton()
        let attributedStirng1 = NSAttributedString(
            string: "닉네임 만들러가기",
            attributes: [ .foregroundColor: UIColor(named: "gray2")!, .underlineStyle: 1 ]
        )
        
        let attributedStirng2 = NSAttributedString(
            string: "닉네임 만들러가기",
            attributes: [ .foregroundColor: UIColor(named: "gray3")!, .underlineStyle: 1 ]
        )
        button.setAttributedTitle(attributedStirng1, for: UIControl.State.normal)
        button.setAttributedTitle(attributedStirng2, for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 400)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [self.makeAccountButton, self.makeNicknameButton])
        stView.axis = .horizontal
        stView.distribution = .fillProportionally
        stView.spacing = 35
        return stView
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "gray4")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        self.configureHierachy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        [self.titleLabel,
         self.idTextField,
         self.pwTextField,
         self.loginButton,
         self.findIDButton,
         self.findPWButton,
         self.seperator,
         self.stackView
        ].forEach { view in
            self.addSubview(view)
        }
        
        self.rightView1.addSubview(self.clearIDButton)
        self.rightView2.addSubview(self.clearPWButton)
        self.rightView2.addSubview(self.hidePWButton)
        
    }
    
    private func setConstraints() {
        self.titleLabel.snp.makeConstraints { label in
            label.centerX.equalToSuperview()
            label.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(90)
        }
        
        self.idTextField.snp.makeConstraints { tf in
            tf.top.equalTo(self.titleLabel.snp.bottom).offset(30)
            tf.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            tf.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            tf.height.equalTo(50)
        }
        
        self.rightView1.snp.makeConstraints { view in
            view.width.equalTo(self.clearIDButton.snp.width).offset(20)
            view.height.equalTo(self.clearIDButton.snp.height)
        }
        
        self.clearIDButton.snp.makeConstraints { btn in
            btn.centerX.equalToSuperview()
            btn.centerY.equalToSuperview()
        }
        
        self.pwTextField.snp.makeConstraints { tf in
            //tf.centerX.equalToSuperview()
            tf.top.equalTo(self.idTextField.snp.bottom).offset(10)
            tf.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            tf.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            tf.height.equalTo(52)
        }
        
        self.rightView2.snp.makeConstraints { view in
            view.height.equalTo(self.hidePWButton.snp.height)
        }
        
        self.clearPWButton.snp.makeConstraints { btn in
            btn.centerY.equalToSuperview()
            btn.leading.equalToSuperview().offset(10)
        }
        
        self.hidePWButton.snp.makeConstraints { btn in
            btn.centerY.equalToSuperview()
            btn.leading.equalTo(self.clearPWButton.snp.trailing).offset(10)
            btn.trailing.equalToSuperview().offset(-10)
        }
        
        self.loginButton.snp.makeConstraints { btn in
            btn.centerX.equalToSuperview()
            btn.top.equalTo(self.pwTextField.snp.bottom).offset(21)
            btn.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            btn.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            btn.height.equalTo(52)
        }
        
        self.seperator.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.loginButton.snp.bottom).offset(36)
            view.width.equalTo(1)
            view.height.equalTo(12)
        }
        
        self.findIDButton.snp.makeConstraints { btn in
            btn.centerY.equalTo(self.seperator.snp.centerY)
            btn.trailing.equalTo(self.seperator.snp.leading).offset(-33)
        }
        
        self.findPWButton.snp.makeConstraints { btn in
            btn.centerY.equalTo(self.seperator.snp.centerY)
            btn.leading.equalTo(self.seperator.snp.trailing).offset(33)
        }
        
        self.stackView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.seperator.snp.bottom).offset(28)
        }
    }
    
//    func enableLoginButton() {
//        self.loginButton.backgroundColor = UIColor(named: "TVING_Red")
//        self.loginButton.layer.borderWidth = 0
//        self.loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        self.loginButton.isEnabled = true
//    }
    
//    func disableLoginButton() {
//        self.loginButton.backgroundColor = .clear
//        self.loginButton.layer.borderWidth = 0.5
//        self.loginButton.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
//        self.loginButton.isEnabled = false
//    }
    
}
