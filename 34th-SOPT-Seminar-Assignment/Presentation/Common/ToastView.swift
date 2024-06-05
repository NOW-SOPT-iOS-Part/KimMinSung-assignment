//
//  ToastView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/03.
//

import UIKit

import SnapKit


final class ToastView: UIView {
    
    private var toastType: ToastType
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectiView = UIVisualEffectView(effect: blurEffect)
        return visualEffectiView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 15, weight: 600)
        label.textColor = .white
        return label
    }()
    
    init(type: ToastType, backgroundColor: UIColor? = .darkGray) {
        self.toastType = type
        super.init(frame: .zero)
        
        self.configureViewHierarchy()
        self.setStyle()
        self.setConstraints()
        self.configureData()
        self.setBlurEffect()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewHierarchy() {
        self.addSubviews(self.blurView, self.messageLabel)
    }
    
    private func setStyle() {
        self.clipsToBounds = true
        self.backgroundColor = UIColor.gray2.withAlphaComponent(0.3)
    }
    
    private func setConstraints() {
        
        self.blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureData() {
        switch toastType {
        case .networkError:
            self.messageLabel.text = "네트워크 통신을 확인해 주세요"
        }
    }
    
    private func setBlurEffect() {
        
    }
    
}
