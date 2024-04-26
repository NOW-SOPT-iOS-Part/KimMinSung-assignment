//
//  HomeView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/26.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .systemGreen
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemOrange
        self.configureViewHierarchy()
        self.setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        self.addSubview(collectionView)
    }
    
    private func setAutoLayout() {
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.collectionView.contentSize.height = 1300
    }
    
    
    
}
