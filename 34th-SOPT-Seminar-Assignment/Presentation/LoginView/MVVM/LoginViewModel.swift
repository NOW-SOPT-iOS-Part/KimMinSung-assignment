//
//  LoginViewModel.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/01.
//

import UIKit

import RxSwift
import RxCocoa

//MARK: Input
//프로토콜로 구현해도 될 듯?(추상화)
struct LoginViewModelInput {
    
    //MARK: IDTextField
    //ID TextField editing began
    let idTexFieldEditingDidBegin: ControlEvent<Void>
    //ID TextField text changed
    let idTextFieldEditingChange: ControlProperty<String>
//    //ID TextField editing end
//    let idTextFieldEditingDidEnd: ControlEvent<Void>
//    //ID TextField return Key tapped
//    let idTextFieldEditingDidEndOnExit: ControlEvent<Void>
    //ID TextField editing end
    let idTextFieldAllEditingEndEvent: ControlEvent<Void>
    
    //MARK: PWTextField
    //PW TextField editing began
    let pwTextFieldEditingDidBegan: ControlEvent<Void>
    //PW TextField text changed
    let pwTextFieldEditingChange: ControlProperty<String>
//    //PW TextField editing end
//    let pwTextFieldEditingDidEnd: ControlEvent<Void>
//    //PW TextField return Key tapped
//    let pwTextFieldEditingDidEndOnExit: ControlEvent<Void>
    //PW TextField editing end
    let pwTextFieldAllEditingEndEvent: ControlEvent<Void>
    
    //MARK: Buttons in TextField
    //clearIDButton tapped
    let clearIDButtonTap: ControlEvent<Void>
    //clearPWButton tapped
    let clearPWButtonTap: ControlEvent<Void>
    //hidePWButton tapped
    let hidePWButtonTap: ControlEvent<Void>
    
    //MARK: LoginButton Enabling Check
    //loginButton tapped
    let loginButtonTap: ControlEvent<Void>
    
    //MARK: AccountRelatedButton
    //findIDBUtton tapped
    let findIDButtonTap: ControlEvent<Void>
    //findPWButton tapped
    let findPWButtonTap: ControlEvent<Void>
    //makeAccountButton tapped
    let makeAccountButtonTap: ControlEvent<Void>
    //makeNicknameButton tapped
    let makeNicknameButtonTap: ControlEvent<Void>
}


//MARK: Output
//프로토콜로 구현해도 될 듯?(추상화)
struct LoginViewModelOutput {
    
    ///set idTextField border line's width
    ///If the value of the element is true, the border of the text field is shown; otherwise, the border of the text field is hidden.
    let setIDTextFieldBorderLine: PublishRelay<Bool> = PublishRelay<Bool>()
    ///hide clearIDButton if text is empty.
    ///If the value of the element is true, the text field is empty, so button should be hidden.
    let hideClearIDButtonIfIDEmpty: PublishRelay<Bool> = PublishRelay<Bool>()
    
    ///set pwTextField border line's width
    ///If the value of the element is true, the border of the text field is shown; otherwise, the border of the text field is hidden.
    let setPWTextFieldBorderLine: PublishRelay<Bool> = PublishRelay<Bool>()
    //hide clearPWButton if text is empty.
    let hideClearPWButtonIfIDEmpty: PublishRelay<Bool> = PublishRelay<Bool>()
    
    //when clearIDButton tapped
    let shouldClearIDTextField: PublishRelay<Void> = PublishRelay<Void>()
    //when clearPWButton tapped
    let shouldClearPWTextField: PublishRelay<Void> = PublishRelay<Void>()
    ///when hidePWButton tapped
    ///the value of the element indicates whether hidePWButton is selected or not.
    let shouldToggleHidePWButton: PublishRelay<Void> = PublishRelay<Void>()
    
    //when loginButton tapped
    let shouldPresentWelcomeVC: PublishRelay<Void> = PublishRelay<Void>()
    //when findIDButton tapped
    let shouldPresentFindIDVC: PublishRelay<Void> = PublishRelay<Void>()
    //when findPWButton tapped
    let shouldPresentFindPWVC: PublishRelay<Void> = PublishRelay<Void>()
    //when makeAccountButton tapped
    let shouldPresentMakeAccountVC: PublishRelay<Void> = PublishRelay<Void>()
    //when makeNicknameButton tapped
    let shouldPresentMakeNicknameVC: PublishRelay<Void> = PublishRelay<Void>()
    
    //check if both ID and PW are in valid format.
    let checkIDPWFormatBehavior: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
}



final class LoginViewModel: ViewModelType_Rx {
    
    typealias Input = LoginViewModelInput
    typealias Output = LoginViewModelOutput
    
    //ID TextField Value checking
    let idInputTextBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    //PW TextField Value checking
    let pwInputTextBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    //IDInput Format checking
    let checkIDFormatBehavior: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    //PWInput Format checking
    let checkPWFormatBehavior: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    //MARK: transform
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        
        let output = Output()
        
        input.idTexFieldEditingDidBegin.subscribe(onNext: { output.setIDTextFieldBorderLine.accept(true) }).disposed(by: disposeBag)
        input.idTextFieldEditingChange.bind(to: self.idInputTextBehavior).disposed(by: disposeBag)
        input.idTextFieldEditingChange.map({ $0.isEmpty }).bind(to: output.hideClearIDButtonIfIDEmpty).disposed(by: disposeBag)
        input.idTextFieldAllEditingEndEvent.subscribe(onNext: { output.setIDTextFieldBorderLine.accept(false) }).disposed(by: disposeBag)
        
        input.pwTextFieldEditingDidBegan.subscribe(onNext: { output.setPWTextFieldBorderLine.accept(true) }).disposed(by: disposeBag)
        input.pwTextFieldEditingChange.bind(to: self.pwInputTextBehavior).disposed(by: disposeBag)
        input.pwTextFieldEditingChange.map({ $0.isEmpty }).bind(to: output.hideClearPWButtonIfIDEmpty).disposed(by: disposeBag)
        input.pwTextFieldAllEditingEndEvent.subscribe(onNext: { output.setPWTextFieldBorderLine.accept(false) }).disposed(by: disposeBag)
        
        input.clearIDButtonTap.bind(to: output.shouldClearIDTextField).disposed(by: disposeBag)
        input.clearPWButtonTap.bind(to: output.shouldClearPWTextField).disposed(by: disposeBag)
        input.hidePWButtonTap.bind(to: output.shouldToggleHidePWButton).disposed(by: disposeBag)
        
        input.loginButtonTap.bind(to: output.shouldPresentWelcomeVC).disposed(by: disposeBag)
        input.findIDButtonTap.bind(to: output.shouldPresentFindIDVC).disposed(by: disposeBag)
        input.findPWButtonTap.bind(to: output.shouldPresentFindPWVC).disposed(by: disposeBag)
        input.makeAccountButtonTap.bind(to: output.shouldPresentMakeAccountVC).disposed(by: disposeBag)
        input.makeNicknameButtonTap.bind(to: output.shouldPresentMakeNicknameVC).disposed(by: disposeBag)
        
        
//        input.idTextFieldEditingChange
//            .map({ [unowned self] in self.isValidEmailFormat(input: $0) })
//            .bind(to: self.checkIDFormatBehavior)
//            .disposed(by: disposeBag)
//
//        input.pwTextFieldEditingChange
//            .map({ [unowned self] in self.isValidPasswordFormat(input: $0) })
//            .bind(to: self.checkPWFormatBehavior)
//            .disposed(by: disposeBag)
        
        self.idInputTextBehavior
            .map(self.isValidEmailFormat(input:))
            .bind(to: self.checkIDFormatBehavior)
            .disposed(by: disposeBag)
        
        self.pwInputTextBehavior
            .map(self.isValidPasswordFormat(input:))
            .bind(to: self.checkPWFormatBehavior)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            self.checkIDFormatBehavior,
            self.checkPWFormatBehavior,
            resultSelector: { $0 && $1 }
        )
        .bind(to: output.checkIDPWFormatBehavior)
        .disposed(by: disposeBag)
        
        return output
    }
    
    
    
    private func isValidEmailFormat(input: String) -> Bool {
        !input.isEmpty
    }
    
    private func isValidPasswordFormat(input: String) -> Bool {
        !input.isEmpty
    }
    
}
