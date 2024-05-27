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
    
    func setRootViewController(_ viewController: UIViewController, animated: Bool = true, transitionType: CATransitionType = .fade) {
        
        if animated {
            // Create a transition animation
            let transition = CATransition()
            transition.type = transitionType
            transition.duration = 0.3
            
            // Add the transition animation to the window
            self.layer.add(transition, forKey: kCATransition)
            
            // Change the root view controller
            self.rootViewController = viewController
            
            // Make the window key and visible
            self.makeKeyAndVisible()
        } else {
            self.rootViewController = viewController
            self.makeKeyAndVisible()
        }
    }
    
}
