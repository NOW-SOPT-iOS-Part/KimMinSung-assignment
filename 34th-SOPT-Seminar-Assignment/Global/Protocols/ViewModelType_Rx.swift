//
//  ViewModelType_Rx.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/01.
//

import RxSwift

protocol ViewModelType_Rx {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, disposeBag: RxSwift.DisposeBag) -> Output
}
