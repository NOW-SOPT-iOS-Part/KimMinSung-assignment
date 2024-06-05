//
//  Toast.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/03.
//

import UIKit

import SnapKit

@frozen
enum ToastType {
    case networkError
}

enum ToastAnimationType {
    case fadeInOut
    case pushFromBottom
}

final class Toast {
    
    static var isPushAnimatorEnd: Bool = false
    
    static let animatorForPushing = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7)
    static let animatorForDismissing = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7)
    
    static var toastView: ToastView!
    static var toastHeight: CGFloat!
    static var toastViewBottomConstraint: NSLayoutConstraint!
    
    static func show (type: ToastType, animationType: ToastAnimationType = .fadeInOut, duration: TimeInterval = 1, isTabBar: Bool = true, completion: (() -> Void)? = nil) {
        
        //guard let window = UIWindow.current else { return }
        let window = UIWindow.current
        
        self.toastView = ToastView(type: type)
        
        self.toastViewBottomConstraint = toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -120)
        
        window.subviews
            .filter { $0 is ToastView }
            .forEach { $0.removeFromSuperview() }
        window.addSubview(toastView)
        
        switch type {
        case .networkError:
            self.toastHeight = 48
        }
        
        //makeCornerRound(radius: CGFloat(toastHeight)/2)
        toastView.clipsToBounds = true
        toastView.layer.cornerRadius = CGFloat(toastHeight)/2
        toastViewBottomConstraint.isActive = true
        toastView.snp.makeConstraints {
            //$0.bottom.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(toastHeight)
        }
        
        window.layoutSubviews()
        
        switch animationType {
        case .fadeInOut:
            fadeIn(completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    fadeOut(completion: {
                        completion?()
                    })
                }
            })
            
        case .pushFromBottom:
            pushFromBottom {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    dismissToBottom {
                        completion?()
                    }
                }
            }
            
        }
        
        func fadeIn(completion: (() -> Void)? = nil) {
            toastView.alpha = 0
            UIView.animate(withDuration: 0.5) {
                toastView.alpha = 1
            } completion: { _ in
                completion?()
            }
            
        }
        
        func fadeOut(completion: (() -> Void)? = nil) {
            toastView.alpha = 1
            UIView.animate(withDuration: 0.5) {
                toastView.alpha = 0
            } completion: { _ in
                toastView.removeFromSuperview()
                completion?()
            }
        }
        
        func pushFromBottom(completion: @escaping () -> Void) {
            print(#function)
            self.isPushAnimatorEnd = false
            
            animatorForDismissing.stopAnimation(true)
            animatorForPushing.stopAnimation(true)
            
            toastViewBottomConstraint.constant = toastHeight
            window.layoutIfNeeded()
            animatorForPushing.addAnimations {
                toastViewBottomConstraint.constant = -120
                window.layoutIfNeeded()
            }
            animatorForPushing.addCompletion { _ in
                self.isPushAnimatorEnd = true
                completion()
            }
            animatorForPushing.startAnimation()
        }
        
        func dismissToBottom(completion: @escaping () -> Void) {
            print(#function)
            toastViewBottomConstraint.constant = -120
            animatorForDismissing.addAnimations {
                toastViewBottomConstraint.constant = toastHeight
                window.layoutIfNeeded()
            }
            animatorForDismissing.addCompletion { _ in completion() }
            
            
            //중간에 새로 버튼이 눌려서 pushFromBottom 이 호출되게 되면, isPushAnimatorEnd 값이 false로 바뀌게 된다.
            //지금까지 생겼던 문제가, 중간에 새로 버튼이 눌렸을 때에도 dismissToBottom 함수가 completion으로 실행된다는 것이었는데,
            //중간에 새로 버튼이 눌렸을 때 isPushAnimationEnd 값을 false로 바꿔주고, dismissToBottom 함수 안에서 isPushAnimationEnd 값이 true 일때만 실행하게 함으로써
            //중간에 새로 버튼이 눌리면 이전 단계의 animatorForDismisisng 이 startAnimation() 함수를 호출하는 것을 막을 수 있다!!!!!!!!
            if self.isPushAnimatorEnd {
                animatorForDismissing.startAnimation()
            } else {
                
            }

        }
        
    }
}
