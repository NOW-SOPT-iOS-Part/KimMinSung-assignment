//
//  UIViewExtensions.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/03.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
}
