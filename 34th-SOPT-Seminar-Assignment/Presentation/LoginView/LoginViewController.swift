//
//  LoginViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/13.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let rootView: LoginView = LoginView()
    
    var nickname: String?
    var id: String!
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        self.setDelegates()
        self.setTargetActions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setDelegates() {
        self.rootView.idTextField.delegate = self
        self.rootView.pwTextField.delegate = self
    }
    
    private func setTargetActions() {
        self.rootView.idTextField.addTarget(self, action: #selector(idTextFieldEditingChanged), for: UIControl.Event.allEditingEvents)
        self.rootView.pwTextField.addTarget(self, action: #selector(pwTextFieldEditingChanged), for: UIControl.Event.allEditingEvents)
        self.rootView.clearButton1.addTarget(self, action: #selector(clearButton1DidTapped), for: UIControl.Event.touchUpInside)
        self.rootView.clearButton2.addTarget(self, action: #selector(clearButton2DidTapped), for: UIControl.Event.touchUpInside)
        self.rootView.hidePWButton.addTarget(self, action: #selector(hidePWButtonDidTapped), for: UIControl.Event.touchUpInside)
        self.rootView.loginButton.addTarget(self, action: #selector(loginButtonDidTapped), for: UIControl.Event.touchUpInside)
        self.rootView.findIDButton.addTarget(self, action: #selector(findIDButtonDidTapped), for: UIControl.Event.touchUpInside)
        self.rootView.findIDButton.addTarget(self, action: #selector(findIDButtonDidTapped), for: UIControl.Event.touchUpInside)
        self.rootView.findPWButton.addTarget(self, action: #selector(findPWButtonDidTapped), for: UIControl.Event.touchUpInside)
        self.rootView.makeAccountButton.addTarget(self, action: #selector(makeAccountButtonDidTapped), for: UIControl.Event.touchUpInside)
        self.rootView.makeNicknameButton.addTarget(self, action: #selector(makeNicknameButtonDidTapped), for: UIControl.Event.touchUpInside)
    }
    
    private func checkLoginButtonColor() {
        if !self.rootView.idTextField.text!.isEmpty && !self.rootView.pwTextField.text!.isEmpty {
            self.enableLoginButton()
        } else {
            self.disableLoginButton()
        }
    }
    
    private func enableLoginButton() {
        self.rootView.loginButton.backgroundColor = UIColor(named: "TVING_Red")
        self.rootView.loginButton.layer.borderWidth = 0
        self.rootView.loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.rootView.loginButton.isEnabled = true
    }
    
    private func disableLoginButton() {
        self.rootView.loginButton.backgroundColor = .clear
        self.rootView.loginButton.layer.borderWidth = 0.5
        self.rootView.loginButton.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
        self.rootView.loginButton.isEnabled = false
    }
    
    @objc private func clearButton1DidTapped() {
        print(#function)
        self.rootView.idTextField.text = ""
        self.disableLoginButton()
    }
    
    @objc private func clearButton2DidTapped() {
        print(#function)
        self.rootView.pwTextField.text = ""
        self.disableLoginButton()
    }
    
    @objc private func hidePWButtonDidTapped() {
        print(#function)
        self.rootView.pwTextField.isSecureTextEntry.toggle()
        switch self.rootView.pwTextField.isSecureTextEntry {
        case true:
            self.rootView.hidePWButton.setImage(UIImage(named: "eye.slash"), for: UIControl.State.normal)
        case false:
            self.rootView.hidePWButton.setImage(UIImage(named: "eye.filled"), for: UIControl.State.normal)
        }
    }
    
    @objc func loginButtonDidTapped() {
        print(#function)
        let id = self.rootView.idTextField.text!
        let welcomeVC = WelcomeViewController(nickname: nickname, id: id)
        welcomeVC.modalPresentationStyle = .fullScreen
        self.present(welcomeVC, animated: true)
    }
    
    @objc private func findIDButtonDidTapped() {
        print(#function)
        self.present(FindIDWebViewController(), animated: true)
    }
    
    @objc private func findPWButtonDidTapped() {
        print(#function)
        self.present(FindPasswordWebViewController(), animated: true)
    }
    
    @objc private func makeAccountButtonDidTapped() {
        print(#function)
        self.present(MakeAccountWebViewController(), animated: true)
    }
    
    @objc private func makeNicknameButtonDidTapped() {
        print(#function)
        
        let makeNicknameVC = MakeNicknameViewController()
        makeNicknameVC.modalPresentationStyle = .formSheet
        if let sheet = makeNicknameVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24.0
        }
        self.present(makeNicknameVC, animated: true)
    }
    
    @objc private func idTextFieldEditingChanged() {
        print(#function)
        if self.rootView.idTextField.text!.isEmpty {
            self.rootView.clearButton1.isHidden = true
        } else {
            self.rootView.clearButton1.isHidden = false
        }
        self.checkLoginButtonColor()
    }
    
    @objc private func pwTextFieldEditingChanged() {
        print(#function)
        if self.rootView.pwTextField.text!.isEmpty {
            self.rootView.clearButton2.isHidden = true
        } else {
            self.rootView.clearButton2.isHidden = false
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
