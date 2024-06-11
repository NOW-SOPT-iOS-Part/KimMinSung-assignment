//
//  UIScreenExtension.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit

extension UIScreen {
    static var current: UIScreen {
        UIWindow.current.screen
    }
}
