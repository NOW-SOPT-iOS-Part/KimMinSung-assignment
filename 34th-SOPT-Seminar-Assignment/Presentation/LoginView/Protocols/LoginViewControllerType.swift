//
//  LoginViewControllerType.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/02.
//

import RxSwift

protocol LoginViewControllerType {
    
    var rootView: LoginView { get }
    var nickname: String? { get set }
    var id: String! { get set }
    
    var disposeBag: DisposeBag { get set }
    
}
