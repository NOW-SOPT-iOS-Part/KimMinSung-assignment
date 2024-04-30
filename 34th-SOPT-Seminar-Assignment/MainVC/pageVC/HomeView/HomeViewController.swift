//
//  HomeViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    let rootView = HomeView()
    
    let homePosterDummy = DummyDataMaker.shared.makeContentsDummy(kind: .homePoster)
    let mustSeeInTvingDummy = DummyDataMaker.shared.makeContentsDummy(kind: .mustSeeInTving)
    let popularLiveDummy = DummyDataMaker.shared.makeContentsDummy(kind: .popularLiveChannel)
    let paramountPlusDummy = DummyDataMaker.shared.makeContentsDummy(kind: .paramountPlus)
    let magicalMoviewDummy = DummyDataMaker.shared.makeContentsDummy(kind: .magicalMovie)
    let quickVODDummy = DummyDataMaker.shared.makeContentsDummy(kind: .quickVOD)
    
    lazy var homePosterVCsDummyData: [HomePosterViewController] = {
        var vcArray = Array<HomePosterViewController>()
        self.homePosterDummy.forEach { content in
            let homePosterVC = HomePosterViewController()
            homePosterVC.configureData(with: content)
            vcArray.append(homePosterVC)
        }
        
        return vcArray
    }()
    
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.setNaviBar()
        self.setDelegates()
    }
    
    private func setDelegates() {
        self.rootView.collectionView.dataSource = self
        /* collectionView의 delegate는 MainViewController 인스턴스에 할당 */
        //self.rootView.collectionView.delegate = self
    }
}


extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionKind.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.mustSeeInTvingDummy.count
        case 2:
            return self.popularLiveDummy.count
        case 3:
            return self.paramountPlusDummy.count
        case 4:
            return self.magicalMoviewDummy.count
        case 5:
            return self.quickVODDummy.count
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.reuseIdentifier,
            for: indexPath
        ) as? HomeHeaderView else { fatalError() }
        
        switch indexPath.section {
        case 1:
            return headerView.withHeaderTitle("티빙에서 꼭 봐야하는 콘텐츠")
        case 2:
            return headerView.withHeaderTitle("인기 LIVE 채널")
        case 3:
            return headerView.withHeaderTitle("1화 무료! 파라마운트+ 인기 시리즈")
        case 4:
            return headerView.withHeaderTitle("마술보다 더 신비로운 영화(신비로운 영화사전님)")
        case 5:
            return headerView.withHeaderTitle("Quick VOD")
        default:
            return headerView
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //guard let pagingCell = collectionView.dequeueReusableCell(
        //    withReuseIdentifier: HomePosterPagingCell.reuseIdentifier,
        //    for: indexPath
        //) as? HomePosterPagingCell else { fatalError() }
        
        //guard let verticalCell = collectionView.dequeueReusableCell(
        //    withReuseIdentifier: HomeVerticalRectCell.reuseIdentifier,
        //    for: indexPath
        //) as? HomeVerticalRectCell else { fatalError() }
        
        //guard let liveContentCell = collectionView.dequeueReusableCell(
        //    withReuseIdentifier: HomeLiveContentCell.reuseIdentifier,
        //    for: indexPath
        //) as? HomeLiveContentCell else { fatalError() }
        
        //guard let quickVODCell = collectionView.dequeueReusableCell(
        //    withReuseIdentifier: HomeQuickVODCell.reuseIdentifier,
        //    for: indexPath
        //) as? HomeQuickVODCell else { fatalError() }
        
        
        switch indexPath.section {
        case 0:
            guard let pagingCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomePosterPagingCell.reuseIdentifier,
                for: indexPath
            ) as? HomePosterPagingCell else { fatalError() }
            
            pagingCell.vcArray = self.homePosterVCsDummyData
            return pagingCell
            
        case 1:
            guard let verticalCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeVerticalRectCell.reuseIdentifier,
                for: indexPath
            ) as? HomeVerticalRectCell else { fatalError() }
            
            verticalCell.configureData(with: self.mustSeeInTvingDummy[indexPath.item])
            return verticalCell
            
        case 2:
            guard let liveContentCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeLiveContentCell.reuseIdentifier,
                for: indexPath
            ) as? HomeLiveContentCell else { fatalError() }
            
            liveContentCell.configureData(with: self.popularLiveDummy[indexPath.item])
            return liveContentCell
            
        case 3:
            guard let verticalCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeVerticalRectCell.reuseIdentifier,
                for: indexPath
            ) as? HomeVerticalRectCell else { fatalError() }
            
            verticalCell.configureData(with: self.paramountPlusDummy[indexPath.item])
            return verticalCell
            
        case 4:
            guard let verticalCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeVerticalRectCell.reuseIdentifier,
                for: indexPath
            ) as? HomeVerticalRectCell else { fatalError() }
            
            verticalCell.configureData(with: self.magicalMoviewDummy[indexPath.item])
            return verticalCell
            
        case 5:
            guard let quickVODCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeQuickVODCell.reuseIdentifier,
                for: indexPath
            ) as? HomeQuickVODCell else { fatalError() }
            
            quickVODCell.configureData(with: self.quickVODDummy[indexPath.item])
            return quickVODCell
            
        default:
            fatalError()
        }
    }
}
