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
        textField.delegate = self
        textField.addTarget(self, action: #selector(idTextFieldEditingChanged), for: UIControl.Event.allEditingEvents)
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
        textField.delegate = self
        textField.addTarget(self, action: #selector(pwTextFieldEditingChanged), for: UIControl.Event.allEditingEvents)
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
    
    lazy var clearButton1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "x.circle"), for: UIControl.State.normal)
        button.setTitleColor(.lightGray, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(clearButton1DidTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var clearButton2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "x.circle"), for: UIControl.State.normal)
        button.setTitleColor(.lightGray, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(clearButton2DidTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var hidePWButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye.filled"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(hidePWButtonDidTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = CGColor(gray: 0.5, alpha: 1)
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: UIControl.Event.touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var findIDButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "gray3"), for: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(findIDButtonDidTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var findPWButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "gray3"), for: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(findPWButtonDidTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var makeAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("아직 계정이 없으신가요?", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.setTitleColor(UIColor(named: "gray3"), for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "gray4"), for: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(makeAccountButtonDidTapped), for: UIControl.Event.touchUpInside)
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
        button.addTarget(self, action: #selector(makeNicknameButtonDidTapped), for: UIControl.Event.touchUpInside)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.configureHierachy()
        self.setLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
            self.view.addSubview(view)
        }
        
        self.rightView1.addSubview(self.clearButton1)
        self.rightView2.addSubview(self.clearButton2)
        self.rightView2.addSubview(self.hidePWButton)
        
    }
    
    private func setLayout() {
        [self.titleLabel,
         self.idTextField,
         self.pwTextField,
         self.rightView1,
         self.clearButton1,
         self.rightView2,
         self.clearButton2,
         self.hidePWButton,
         
         self.loginButton,
         self.findIDButton,
         self.findPWButton,
         self.seperator,
         self.stackView
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.titleLabel.snp.makeConstraints { label in
            label.centerX.equalToSuperview()
            label.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(90)
        }
        
        self.idTextField.snp.makeConstraints { tf in
            tf.top.equalTo(self.titleLabel.snp.bottom).offset(30)
            tf.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
            tf.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            tf.height.equalTo(50)
        }
        
        self.rightView1.snp.makeConstraints { view in
            view.width.equalTo(self.clearButton1.snp.width).offset(20)
            view.height.equalTo(self.clearButton1.snp.height)
        }
        
        self.clearButton1.snp.makeConstraints { btn in
            btn.centerX.equalToSuperview()
            btn.centerY.equalToSuperview()
        }
        
        self.pwTextField.snp.makeConstraints { tf in
            //tf.centerX.equalToSuperview()
            tf.top.equalTo(self.idTextField.snp.bottom).offset(10)
            tf.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
            tf.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            tf.height.equalTo(52)
        }
        
        self.rightView2.snp.makeConstraints { view in
            view.height.equalTo(self.hidePWButton.snp.height)
        }
        
        self.clearButton2.snp.makeConstraints { btn in
            btn.centerY.equalToSuperview()
            btn.leading.equalToSuperview().offset(10)
        }
        
        self.hidePWButton.snp.makeConstraints { btn in
            btn.centerY.equalToSuperview()
            btn.leading.equalTo(self.clearButton2.snp.trailing).offset(10)
            btn.trailing.equalToSuperview().offset(-10)
        }
        
        self.loginButton.snp.makeConstraints { btn in
            btn.centerX.equalToSuperview()
            btn.top.equalTo(self.pwTextField.snp.bottom).offset(21)
            btn.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
            btn.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
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
    
    private func checkLoginButtonColor() {
        if !self.idTextField.text!.isEmpty && !self.pwTextField.text!.isEmpty {
            self.enableLoginButton()
        } else {
            self.disableLoginButton()
        }
    }
    
    private func enableLoginButton() {
        self.loginButton.backgroundColor = UIColor(named: "TVING_Red")
        self.loginButton.layer.borderWidth = 0
        self.loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.loginButton.isEnabled = true
    }
    
    private func disableLoginButton() {
        self.loginButton.backgroundColor = .clear
        self.loginButton.layer.borderWidth = 0.5
        self.loginButton.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
        self.loginButton.isEnabled = false
    }
    
    @objc private func clearButton1DidTapped() {
        print(#function)
        self.idTextField.text = ""
        self.disableLoginButton()
    }
    
    @objc private func clearButton2DidTapped() {
        print(#function)
        self.pwTextField.text = ""
        self.disableLoginButton()
    }
    
    @objc private func hidePWButtonDidTapped() {
        print(#function)
        self.pwTextField.isSecureTextEntry.toggle()
        switch self.pwTextField.isSecureTextEntry {
        case true:
            self.hidePWButton.setImage(UIImage(named: "eye.slash"), for: UIControl.State.normal)
        case false:
            self.hidePWButton.setImage(UIImage(named: "eye.filled"), for: UIControl.State.normal)
        }
    }
    
    @objc func loginButtonDidTapped() {
        print(#function)
        let welcomeVC = WelcomeViewController()
        welcomeVC.modalPresentationStyle = .fullScreen
        self.present(welcomeVC, animated: true)
    }
    
    @objc private func findIDButtonDidTapped() {
        print(#function)
    }
    
    @objc private func findPWButtonDidTapped() {
        print(#function)
    }
    
    @objc private func makeAccountButtonDidTapped() {
        print(#function)
    }
    
    @objc private func makeNicknameButtonDidTapped() {
        print(#function)
    }
    
    @objc private func idTextFieldEditingChanged() {
        print(#function)
        if self.idTextField.text!.isEmpty {
            self.clearButton1.isHidden = true
        } else {
            self.clearButton1.isHidden = false
        }
        self.checkLoginButtonColor()
    }
    
    @objc private func pwTextFieldEditingChanged() {
        print(#function)
        if self.pwTextField.text!.isEmpty {
            self.clearButton2.isHidden = true
        } else {
            self.clearButton2.isHidden = false
        }
        self.checkLoginButtonColor()
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        textField.layer.borderWidth = 1
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 0
        
        return true
    }
    
}
