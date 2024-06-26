//
//  UIWindowExtensions.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/28.
//

import UIKit



extension UIWindow {
    static var current: UIWindow {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else {
                fatalError()
            }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        fatalError()
    }
}
