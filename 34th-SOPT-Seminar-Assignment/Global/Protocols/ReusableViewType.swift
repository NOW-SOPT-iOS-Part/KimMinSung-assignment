//
//  ReusableViewType.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/05.
//

//import Foundation

protocol ReusableViewType {
    
    static var reuseIdentifier: String { get }
    
}

extension ReusableViewType {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
