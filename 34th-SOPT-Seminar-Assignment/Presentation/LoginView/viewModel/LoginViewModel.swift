//
//  LoginViewModel.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/01.
//

import Foundation

import RxSwift

final class LoginViewModel: ViewModelType_Rx {
    
    //typealias Input = <#type#>
    //typealias Output = <#type#>
    
    
    /// Input 이벤트
    struct Input {
        
        //MARK: IDTextField
        //ID TextField editing changed
        //ID TextField text changed
        //ID TextField editing end
        //ID TextField return Key tapped
        
        //ID TextField Value checking
        
        //MARK: PWTextField
        //PW TextField editing chagned
        //PW TextField text changed
        //PW TextField editing changed
        //PW TextField return Key tapped
        
        //PW TextField Value checking
        
        //MARK: Buttons in TextField
        //clearIDButton tapped
        //clearPWButton tapped
        //hidePWButton tapped
        
        //MARK: LoginButton
        //???
        
        //MARK: AccountRelatedButton
        //findIDBUtton tapped
        //findPWButton tapped
        //makeAccountButton tapped
        //makeNicknameButton tapped
    }
    
    
    struct Output {
        
    }
    
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        <#code#>
    }
    
    
}
