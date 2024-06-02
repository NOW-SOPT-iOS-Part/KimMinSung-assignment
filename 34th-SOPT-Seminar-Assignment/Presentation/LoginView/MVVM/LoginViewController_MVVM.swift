//
//  LoginViewController_MVVM.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/02.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class LoginViewController_MVVM: UIViewController {
    
    let viewModel: LoginViewModel
    let rootView: LoginView = LoginView()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
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
        
        self.bindViewModel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bindViewModel() {
        
        //Input Binding
        let input = LoginViewModelInput(
            idTexFieldEditingDidBegin: self.rootView.idTextField.rx.controlEvent(.editingDidBegin),
            idTextFieldEditingChange: self.rootView.idTextField.rx.text.orEmpty,
            idTextFieldAllEditingEndEvent: self.rootView.idTextField.rx.controlEvent([.editingDidEnd, .editingDidEndOnExit]),
            
            pwTextFieldEditingDidBegan: self.rootView.pwTextField.rx.controlEvent(.editingDidBegin),
            pwTextFieldEditingChange: self.rootView.pwTextField.rx.text.orEmpty,
            pwTextFieldAllEditingEndEvent: self.rootView.pwTextField.rx.controlEvent([.editingDidEnd, .editingDidEndOnExit]),
            
            clearIDButtonTap: self.rootView.clearIDButton.rx.tap,
            clearPWButtonTap: self.rootView.clearPWButton.rx.tap,
            hidePWButtonTap: self.rootView.hidePWButton.rx.tap,
            
            loginButtonTap: self.rootView.loginButton.rx.tap,
            findIDButtonTap: self.rootView.findIDButton.rx.tap,
            findPWButtonTap: self.rootView.findPWButton.rx.tap,
            makeAccountButtonTap: self.rootView.makeAccountButton.rx.tap,
            makeNicknameButtonTap: self.rootView.makeNicknameButton.rx.tap
        )
        
        //Output Binding
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.setIDTextFieldBorderLine
            .subscribe(onNext: { [unowned self] isBorderHidden in 
                self.setTextFieldBorderWidth(textField: self.rootView.idTextField, isBorderShown: isBorderHidden)
            }).disposed(by: self.disposeBag)
        
        output.hideClearIDButtonIfIDEmpty
            .subscribe(onNext: { [unowned self] isTextEmpty in
                self.rootView.clearIDButton.isHidden = isTextEmpty
            }).disposed(by: self.disposeBag)
        
        output.setPWTextFieldBorderLine
            .subscribe(onNext: { [unowned self] isBorderHidden in
                self.setTextFieldBorderWidth(textField: self.rootView.pwTextField, isBorderShown: isBorderHidden)
            }).disposed(by: self.disposeBag)
        
        output.hideClearPWButtonIfIDEmpty
            .subscribe(onNext: { [unowned self] isTextEmpty in
                self.rootView.clearPWButton.isHidden = isTextEmpty
            }).disposed(by: self.disposeBag)
        
        output.shouldClearIDTextField
            .subscribe(onNext: { [unowned self] in
                self.rootView.idTextField.text = ""
                self.rootView.idTextField.sendActions(for: .valueChanged)
            }).disposed(by: self.disposeBag)
        
        output.shouldClearPWTextField
            .subscribe(onNext: { [unowned self] in
                self.rootView.pwTextField.text = ""
                self.rootView.pwTextField.sendActions(for: .valueChanged)
            }).disposed(by: self.disposeBag)
        
        output.shouldToggleHidePWButton
            .subscribe(onNext: { [unowned self] in
                let hidePWButton = self.rootView.hidePWButton
                hidePWButton.isSelected.toggle()
                self.rootView.pwTextField.isSecureTextEntry = hidePWButton.isSelected
            }).disposed(by: self.disposeBag)
        
        output.shouldPresentWelcomeVC
            .subscribe(onNext: { [unowned self] in
                let id = self.viewModel.id
                let nickname = self.viewModel.nickname
                let welcomeVC = WelcomeViewController(nickname: nickname, id: id)
                //welcomeVC.modalPresentationStyle = .fullScreen
                welcomeVC.modalPresentationStyle = .formSheet
                self.present(welcomeVC, animated: true)
            }).disposed(by: self.disposeBag)
        
        output.shouldPresentFindIDVC
            .subscribe(onNext: { [unowned self] in
                self.present(FindIDWebViewController(), animated: true)
            }).disposed(by: self.disposeBag)
        
        output.shouldPresentFindPWVC
            .subscribe(onNext: { [unowned self] in
                self.present(FindPasswordWebViewController(), animated: true)
            }).disposed(by: self.disposeBag)
        
        output.shouldPresentMakeAccountVC
            .subscribe(onNext: { [unowned self] in
                self.present(MakeAccountWebViewController(), animated: true)
            }).disposed(by: self.disposeBag)
        
        output.shouldPresentMakeNicknameVC
            .subscribe(onNext: { [unowned self] in
                let makeNicknameVC = MakeNicknameViewController()
                makeNicknameVC.modalPresentationStyle = .formSheet
                if let sheet = makeNicknameVC.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.prefersGrabberVisible = true
                    sheet.preferredCornerRadius = 24.0
                }
                self.present(makeNicknameVC, animated: true)
            }).disposed(by: self.disposeBag)
        
        //ID와 PW의 형식이 맞으면 로그인 버튼을 터치할 수 있도록 변경
        output.checkIDPWFormatBehavior
            .subscribe(
                onNext: { [unowned self] in self.rootView.loginButton.isEnabled = $0 }
            ).disposed(by: self.disposeBag)
        
    }
    
    
    private func subscribeForAccountRelatedButtons() {
        self.rootView.findIDButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.present(FindIDWebViewController(), animated: true)
            }).disposed(by: self.disposeBag)
        
        self.rootView.findPWButton.rx.tap
            .subscribe(onNext: { [unowned self] in self.present(FindPasswordWebViewController(), animated: true) })
            .disposed(by: self.disposeBag)
        
        self.rootView.makeAccountButton.rx.tap
            .subscribe(onNext: { [unowned self] in self.present(MakeAccountWebViewController(), animated: true) })
            .disposed(by: self.disposeBag)
        
        self.rootView.makeNicknameButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                let makeNicknameVC = MakeNicknameViewController()
                makeNicknameVC.modalPresentationStyle = .formSheet
                if let sheet = makeNicknameVC.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.prefersGrabberVisible = true
                    sheet.preferredCornerRadius = 24.0
                }
                self.present(makeNicknameVC, animated: true)
            }).disposed(by: self.disposeBag)
    }
    
    
    private func setTextFieldBorderWidth(textField: UITextField, isBorderShown: Bool) {
        switch isBorderShown {
        case true:
            textField.layer.borderWidth = 1
        case false:
            textField.layer.borderWidth = 0
        }
    }
    
    
}
