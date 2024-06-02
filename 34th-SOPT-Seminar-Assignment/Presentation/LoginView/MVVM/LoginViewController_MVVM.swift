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

class LoginViewController_MVVM: UIViewController, LoginViewControllerType {
    
    let viewModel: LoginViewModel
    let rootView: LoginView = LoginView()
    
    var nickname: String? = ""
    var id: String!
    
    var disposeBag: DisposeBag = DisposeBag()
    
//    let idInputTextBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
//    let pwInputTextBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
//    
//    let checkIDFormatBehavior: BehaviorSubject<Bool> = BehaviorSubject(value: false)
//    let checkPWFormatBehavior: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    
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
        
//        self.subscribeForIDTextField()
//        self.subscribeForIDTextFieldValue()
//        
//        self.subscribeForPWTextField()
//        self.subscribeForPWTextFieldValue()
//        
//        self.subscribeForButtonsInTextField()
//        
//        self.subscribeForLoginButton()
        self.subscribeForAccountRelatedButtons()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bindViewModel() {
        
        let input = LoginViewModelInput(
            idTexFieldEditingDidBegin: self.rootView.idTextField.rx.controlEvent(.editingDidBegin),
            idTextFieldEditingChange: self.rootView.idTextField.rx.text.orEmpty,
//            idTextFieldEditingDidEnd: self.rootView.idTextField.rx.controlEvent(.editingDidEnd),
//            idTextFieldEditingDidEndOnExit: self.rootView.idTextField.rx.controlEvent(.editingDidEndOnExit),
            idTextFieldAllEditingEndEvent: self.rootView.idTextField.rx.controlEvent([.editingDidEnd, .editingDidEndOnExit]),
            pwTextFieldEditingDidBegan: self.rootView.pwTextField.rx.controlEvent(.editingDidBegin),
            pwTextFieldEditingChange: self.rootView.pwTextField.rx.text.orEmpty,
//            pwTextFieldEditingDidEnd: self.rootView.pwTextField.rx.controlEvent(.editingDidEnd),
//            pwTextFieldEditingDidEndOnExit: self.rootView.pwTextField.rx.controlEvent(.editingDidEndOnExit),
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
        
//        let input = LoginViewModelInput(
//            idTextFieldEditingChange: self.rootView.idTextField.rx.text.orEmpty,
//            pwTextFieldEditingChange: self.rootView.pwTextField.rx.text.orEmpty
//        )
        
//        input.idTextFieldEditingChange
//            .subscribe(onNext: { [unowned self] in self.rootView.clearIDButton.isHidden = $0.isEmpty })
//            .disposed(by: self.disposeBag)
//        
//        input.pwTextFieldEditingChange
//            .subscribe(onNext: { [unowned self] in self.rootView.clearPWButton.isHidden = $0.isEmpty })
//            .disposed(by: self.disposeBag)
        
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
                let id = self.rootView.idTextField.text!
                let welcomeVC = WelcomeViewController(nickname: self.nickname, id: id)
                welcomeVC.modalPresentationStyle = .fullScreen
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
        
//        output.shouldPresentMakeNicknameVC
//            .subscribe(onNext: { [unowned self] in
//                let makeNicknameVC = MakeNicknameViewController()
//                makeNicknameVC.modalPresentationStyle = .formSheet
//                if let sheet = makeNicknameVC.sheetPresentationController {
//                    sheet.detents = [.medium()]
//                    sheet.prefersGrabberVisible = true
//                    sheet.preferredCornerRadius = 24.0
//                }
//                self.present(makeNicknameVC, animated: true)
//            }).disposed(by: self.disposeBag)
        
        //ID와 PW의 형식이 맞으면 로그인 버튼을 터치할 수 있도록 변경
        output.checkIDPWFormatBehavior
            .subscribe(
                onNext: { [unowned self] in self.rootView.loginButton.isEnabled = $0 }
            ).disposed(by: self.disposeBag)
        
    }
    
    /* 각 subscibe는 onNext만 구현해도 되지만, RxSwift 공부를 위해 일부 subscrive 메서드에서는 다른 event의 case들도 구현해 보았습니다. */
//    private func subscribeForIDTextField() {
//        
//        //idTextField의 editing이 시작했을 때 -> 테두리 적용
//        self.rootView.idTextField.rx.controlEvent(.editingDidBegin)
//            .subscribe(
//                onNext: { [unowned self] in self.rootView.idTextField.layer.borderWidth = 1 },
//                onError: { print($0.localizedDescription) },
//                onCompleted: { print("idTF editingDidBegin Completed") },
//                onDisposed: { print("idTF editingDidBegin Disposed") }
//            ).disposed(by: self.disposeBag)
//        
////        //idTextField의 text가 바뀌었을 때
////        self.rootView.idTextField.rx.text.orEmpty
////            .subscribe(
////                onNext: { [unowned self] text in
////                    self.idInputTextBehavior.accept(text)
////                    self.rootView.clearIDButton.isHidden = text.isEmpty
////                }).disposed(by: self.disposeBag)
////        /* clearIDButton의 설정이 없다면 다음과 같이 bind 메서드로 축약 가능*/
////        //self.rootView.idTextField.rx.text.orEmpty.bind(to: self.idInputTextBehavior).disposed(by: self.disposeBag)
//        
//        //idTextField의 editing이 끝났을 떄 -> 테두리 제거
//        self.rootView.idTextField.rx.controlEvent(.editingDidEnd)
//            .subscribe({ [unowned self] _ in self.rootView.idTextField.layer.borderWidth = 0 }).disposed(by: self.disposeBag)
//        
//        //idTextField의 return 키를 누름으로써 editing이 끝났을 떄
//        self.rootView.idTextField.rx.controlEvent(.editingDidEndOnExit).asObservable()
//            .subscribe({ [unowned self] _ in self.rootView.idTextField.layer.borderWidth = 0 }).disposed(by: self.disposeBag)
//        
//    }
    
//    private func subscribeForIDTextFieldValue() {
//        self.idInputTextBehavior
//            .map(self.isValidEmailFormat(input:))
//            .bind(to: self.checkIDFormatBehavior).disposed(by: self.disposeBag)
//    }
    
//    private func subscribeForPWTextField() {
//        
//        //pwTextField의 editing이 시작했을 때
//        self.rootView.pwTextField.rx.controlEvent(.editingDidBegin).asObservable()
//            .subscribe(onNext: { [unowned self] in
//                self.rootView.pwTextField.layer.borderWidth = 1 }).disposed(by: self.disposeBag)
//        
////        //pwTextField의 text가 바뀌었을 때
////        self.rootView.pwTextField.rx.text.orEmpty
////            .subscribe(onNext: { [unowned self] text in
////                self.pwInputTextBehavior.accept(text) //BehaviorRelay에 값을 넘겨줌
////                self.rootView.clearPWButton.isHidden = text.isEmpty
////            })
////            .disposed(by: self.disposeBag)
////        /* idTextField와 마찬가지로 clearPWButton의 설정이 없을 경우 bind함수로 축약 가능 */
//        
//        //pwTextField의 editing이 끝났을 때
//        self.rootView.pwTextField.rx.controlEvent(.editingDidEnd).asObservable()
//            .subscribe({ [unowned self] _ in self.rootView.pwTextField.layer.borderWidth = 0 }).disposed(by: self.disposeBag)
//        
//        //pwTextField의 return 키를 누름으로써 editing이 끝났을 떄
//        self.rootView.pwTextField.rx.controlEvent(.editingDidEndOnExit).asObservable()
//            .subscribe({ [unowned self] _ in self.rootView.pwTextField.layer.borderWidth = 0 }).disposed(by: self.disposeBag)
//            
//    }
    
//    private func subscribeForPWTextFieldValue() {
//        self.pwInputTextBehavior
//            .map(self.isValidPasswordFormat(input:))
//            .bind(to: self.checkPWFormatBehavior).disposed(by: self.disposeBag)
//    }
    
    
//    private func subscribeForButtonsInTextField() {
//        self.rootView.clearIDButton.rx.tap
//            .subscribe(onNext: { [unowned self] in
//                /*
//                 RxCocoa의 코드를 살펴보면, textField.rx.text 가 textField.text의 값을 방출하는 경우는
//                 .allEditingEvents, .valueChanges 의 이벤트가 발생했을 때이다. (Reactive 타입의 controlPropertyWithDefaultEvents() 함수에서 확인)
//                 따라서 텍스트필드에 텍스트를 직접 입력하는 것만으로는 textField.rx.text 는 값을 방출하지 않는다.
//                 그래서 수동으로 해당 이벤트를 발생시켰음.
//                 */
//                self.rootView.idTextField.text = ""
//                self.rootView.idTextField.sendActions(for: .valueChanged)
//            }).disposed(by: self.disposeBag)
//        
//        self.rootView.clearPWButton.rx.tap
//            .subscribe(onNext: { [unowned self] in
//                self.rootView.pwTextField.text = ""
//                self.rootView.pwTextField.sendActions(for: .valueChanged)
//            }).disposed(by: self.disposeBag)
//        
//        
//        self.rootView.hidePWButton.rx.tap
//            .subscribe(onNext: { [unowned self] in
////                self.rootView.pwTextField.isSecureTextEntry.toggle()
////                switch self.rootView.pwTextField.isSecureTextEntry {
////                case true:
////                    self.rootView.hidePWButton.setImage(UIImage(named: "eye.slash"), for: UIControl.State.normal)
////                case false:
////                    self.rootView.hidePWButton.setImage(UIImage(named: "eye.filled"), for: UIControl.State.normal)
////                }
//            }).disposed(by: self.disposeBag)
//    }
    
    
//    private func subscribeForLoginButton() {
////        Observable.combineLatest(
////            self.checkIDFormatBehavior,
////            self.checkPWFormatBehavior,
////            resultSelector: { $0 && $1 }
////        ).subscribe(
////            onNext: { [unowned self] isBothInValidFormat in self.rootView.loginButton.isEnabled = isBothInValidFormat },
////            onCompleted: { print("버튼 subscribe completed!") },
////            onDisposed: { print("버튼 subscribe disposed됨!") }
////        ).disposed(by: self.disposeBag)
//        
//        self.rootView.loginButton.rx.tap
//            .subscribe(onNext: { [unowned self] in
//                let id = self.rootView.idTextField.text!
//                let welcomeVC = WelcomeViewController(nickname: self.nickname, id: id)
//                welcomeVC.modalPresentationStyle = .fullScreen
//                self.present(welcomeVC, animated: true)
//            }).disposed(by: self.disposeBag)
//    }
    
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
