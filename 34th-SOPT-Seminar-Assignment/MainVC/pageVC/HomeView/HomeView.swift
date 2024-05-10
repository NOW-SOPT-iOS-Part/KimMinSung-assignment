//
//  HomeView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/26.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    
    
    private let pagingLayoutSection: NSCollectionLayoutSection = {
        let screenSize = UIScreen.main.bounds
        
        let pagingItemSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.estimated(screenSize.width * 1.33)
        )
        
        let pagingItem = NSCollectionLayoutItem(layoutSize: pagingItemSize)
        
        let pagingGroupSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.estimated(screenSize.width * 1.5)
        )
        
        let pagingGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: pagingGroupSize,
            subitems: [pagingItem]
        )
        
        let pagingSection = NSCollectionLayoutSection(group: pagingGroup)
        pagingSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return pagingSection
    }()
    
    private let verticalRectLayoutSection: NSCollectionLayoutSection = {

        let headerSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.absolute(44)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: NSRectAlignment.top
        )
        
        let verticalRectItemSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.estimated(180)
        )
        
        let verticalRectItem = NSCollectionLayoutItem(layoutSize: verticalRectItemSize)
        
        let verticalRectGroupSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.absolute(98),
            heightDimension: NSCollectionLayoutDimension.estimated(180)
        )
        
        let verticalRectGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: verticalRectGroupSize,
            subitems: [verticalRectItem]
        )
        verticalRectGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        verticalRectGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(0)
        
        let verticalRectSection = NSCollectionLayoutSection(group: verticalRectGroup)
        verticalRectSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        verticalRectSection.boundarySupplementaryItems = [sectionHeader]
        verticalRectSection.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        verticalRectSection.interGroupSpacing = 8
        
        return verticalRectSection
    }()
    
    
    // 박스오피스 section을 따로 만들어야 하나...? 하는 생각도 듦...왜냐하면 박스오피스 Section은 헤더 뷰에 날짜 선택하는 좌우 화살표 버튼? 이 있어야 하는데...
    // 그걸 기존 layout section을 재활용하려니 너무 복잡해짐...그냥 깔끔하게! 딱! 크기도 따로 지정해서! 만들면 편할 것 같다
    private let rankingRectLayoutSection: NSCollectionLayoutSection = {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.absolute(44)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: NSRectAlignment.top
        )
        
        let horizontalRectItemSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.estimated(160),
            heightDimension: NSCollectionLayoutDimension.estimated(160)
        )
        
        let horizontalRectItem = NSCollectionLayoutItem(layoutSize: horizontalRectItemSize)
        
        let horizontalRectGroupSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.estimated(160),
            heightDimension: NSCollectionLayoutDimension.estimated(160)
        )
        
        let horizontalRectGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalRectGroupSize,
            subitems: [horizontalRectItem]
        )
        horizontalRectGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        horizontalRectGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(0)
        
        let horizontalRectSection = NSCollectionLayoutSection(group: horizontalRectGroup)
        horizontalRectSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        horizontalRectSection.boundarySupplementaryItems = [sectionHeader]
        horizontalRectSection.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        horizontalRectSection.interGroupSpacing = 8
        
        return horizontalRectSection
    }()
    
    private let quickVODLayoutSection: NSCollectionLayoutSection = {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.absolute(44)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: NSRectAlignment.top
        )
        
        let horizontalRectItemSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.estimated(160)
        )
        
        let horizontalRectItem = NSCollectionLayoutItem(layoutSize: horizontalRectItemSize)
        
        let horizontalRectGroupSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.absolute(160),
            heightDimension: NSCollectionLayoutDimension.estimated(160)
        )
        
        let horizontalRectGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalRectGroupSize,
            subitems: [horizontalRectItem]
        )
        horizontalRectGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        horizontalRectGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(0)
        
        let horizontalRectSection = NSCollectionLayoutSection(group: horizontalRectGroup)
        horizontalRectSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        horizontalRectSection.boundarySupplementaryItems = [sectionHeader]
        horizontalRectSection.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        horizontalRectSection.interGroupSpacing = 8
        
        return horizontalRectSection
    }()
    
    
    private lazy var homeCompositionalLayout: UICollectionViewCompositionalLayout = {
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfiguration.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, env in
            switch sectionIndex {
            case 0:
                return self.pagingLayoutSection
            case 1:
                return self.rankingRectLayoutSection
            case 2:
                return self.verticalRectLayoutSection
            case 3:
                return self.rankingRectLayoutSection
            case 4:
                return self.verticalRectLayoutSection
            case 5:
                return self.verticalRectLayoutSection
            case 6:
                return self.rankingRectLayoutSection
            default:
                fatalError()
            }
        }, configuration: layoutConfiguration)
        
        return layout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.homeCompositionalLayout)
        
        collectionView.register(
            HomeBoxOfficeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeBoxOfficeHeaderView.reuseIdentifier
        )
        
        collectionView.register(
            HomeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.reuseIdentifier
        )
        
        collectionView.register(HomePosterPagingCell.self, forCellWithReuseIdentifier: HomePosterPagingCell.reuseIdentifier)
        collectionView.register(HomeVerticalRectCell.self, forCellWithReuseIdentifier: HomeVerticalRectCell.reuseIdentifier)
        collectionView.register(HomeRankingContentCell.self, forCellWithReuseIdentifier: HomeRankingContentCell.reuseIdentifier)
        collectionView.register(HomeQuickVODCell.self, forCellWithReuseIdentifier: HomeQuickVODCell.reuseIdentifier)
        
        collectionView.backgroundColor = .black
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
    }
    
    
    
    /// collectionView의 contentInset을 설정하는 함수
    ///
    /// - collectionView를 가장 위로 스크롤했을 떄 collection view의 content 상단이 핸드폰 화면의 최상단에 위치하도록 설정하기 위해
    /// contentInsetAdjustmentBehavior에 .never를 할당. 하지만 이 때문에 collection view의 content 하단이 탭바에 가려짐
    /// -> collection view의 contentInset.bottom에 safeAreaInsets.bottom 만큼 할당
    /// 이 함수는 하단 탭바를 포함한 safeAreaInset의 값에 접근할 수 있는 MainViewController에서 호출됨
    func setCollectionViewContentInset(inset: UIEdgeInsets) {
        // collectionView를 가장 위로 스크롤했을 떄 collection view의 content의 상단이 핸드폰 화면의 최상단에 위치하도록 설정
        collectionView.contentInsetAdjustmentBehavior = .never
        /*
         바로 위 코드에서 contentInsetAdjustmentBehavior에 .never를 할당하여 collection view의 content 하단이 탭바에 가려짐
         -> collection view의 contentInset.bottom에 safeAreaInsets.bottom 만큼 할당해 주어야 함
         */
        collectionView.contentInset = inset
    }
    
}
