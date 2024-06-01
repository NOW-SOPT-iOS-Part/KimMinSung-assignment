//
//  LoginViewModel.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/01.
//

import Foundation

import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType_Rx {
    
    //typealias Input = <#type#>
    //typealias Output = <#type#>
    
    
    //MARK: Input
    struct Input {
        
        //MARK: IDTextField
        //ID TextField editing began
        let idTexFieldEditingDidBegin: Observable<Void>
        //ID TextField text changed
        let idTextFieldEditingChange: Observable<String>
        //ID TextField editing end
        let idTextFieldEditingDidEnd: Observable<Void>
        //ID TextField return Key tapped
        let idTextFieldEditingDidEndOnExit: Observable<Void>
        
        //ID TextField Value checking
        let idInputTextBehavior: BehaviorRelay<String>
        
        //MARK: PWTextField
        //PW TextField editing began
        let pwTextFieldEditingDidBegan: Observable<Void>
        //PW TextField text changed
        let pwTextFieldEditingChange: Observable<String>
        //PW TextField editing end
        let pwTextFieldEditingDidEnd: Observable<Void>
        //PW TextField return Key tapped
        let pwTextFieldEditingDidEndOnExit: Observable<Void>
        
        //PW TextField Value checking
        let pwInputTextBehavior: BehaviorRelay<String>
        
        //MARK: Buttons in TextField
        //clearIDButton tapped
        let clearIDButtonTap: Observable<Void>
        //clearPWButton tapped
        let clearPWButtonTap: Observable<Void>
        //hidePWButton tapped
        let hidePWButtonTap: Observable<Void>
        
        //MARK: LoginButton Enabling Check
        //IDInput Format checking
        let checkIDFormatBehavior: BehaviorSubject<Bool>
        //PWInput Format checking
        let checkPWFormatBehavior: BehaviorSubject<Bool>
        //loginButton tapped
        let loginButtonTap: Observable<Void>
        
        //MARK: AccountRelatedButton
        //findIDBUtton tapped
        let fintIDButtonTap: Observable<Void>
        //findPWButton tapped
        let findPWButtonTap: Observable<Void>
        //makeAccountButton tapped
        let makeAccountButtonTap: Observable<Void>
        //makeNicknameButton tapped
        let makeNicknameButtonTap: Observable<Void>
    }
    
    
    //MARK: Output
    struct Output {
        
    }
    
    
    //MARK: transform
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        <#code#>
    }
    
    
}
