//
//  TVINGLoginButton.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/29.
//

import UIKit

final class TVINGLoginButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.isEnabled = false
    }
    
    convenience init(enabledTitle: String, disabledTitle: String) {
        self.init(frame: .zero)
        self.setTitle(enabledTitle, for: .normal)
        self.setTitle(disabledTitle, for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isEnabled: Bool {
        didSet {
            switch self.isEnabled {
            case true:
                self.backgroundColor = UIColor(named: "TVING_Red")
                self.layer.borderWidth = 0
                self.setTitleColor(UIColor.white, for: UIControl.State.normal)
                
            case false:
                self.backgroundColor = .clear
                self.layer.borderWidth = 0.5
                self.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.normal)
                
            }
        }
    }
    
    private func setUI() {
        self.setTitle("로그인하기", for: .normal)
        self.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        self.setTitleColor(UIColor(named: "gray2"), for: UIControl.State.disabled)
        self.setTitleColor(UIColor(named: "TVING_Red"), for: UIControl.State.normal)
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 0.5
        self.layer.borderColor = CGColor(gray: 0.5, alpha: 1)
    }
    
    
    func setEnabledTitle(as title: String) {
        self.setTitle(title, for: .normal)
    }
    
    func setDisabledTitle(as title: String) {
        self.setTitle(title, for: .disabled)
    }
    
}
