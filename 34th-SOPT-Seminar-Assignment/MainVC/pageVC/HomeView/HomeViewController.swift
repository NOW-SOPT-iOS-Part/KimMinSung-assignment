//
//  HomeViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    let rootView = HomeView()
    
    // 반복문을 사용하여 코드를 줄일 수 있을 것 같음.
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
        
        self.setDelegates()
    }
    
    /// self.rootView.collectionView의 dataSource에 self 할당
    ///
    /// collectionView의 delegate는 MainViewController 인스턴스에 할당하므로, 여기에서 delegate를 할당하지 않음.
    private func setDelegates() {
        self.rootView.collectionView.dataSource = self
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
        
        /*
         원래는 아래 코드처럼,cellForItemAt 함수가 호출될 때 각 종류의 cell을 모두 dequeu해 놓고 셀이 놓일 section에 따라 분기처리하여 해당 cell을 반환할 예정이었음.
         그러나 이렇게 할 경우 불필요하게 cell이 많이 dequeu됨을 확인할 수 있었고, 심지어는 너무 많이 dequeu되어, cell 인스턴스가 추가로 계속해서 생기는 현상 발생
         (물론 다시 메모리에서 내려가긴 하지만...지나친 cell의 생성과 소멸은 deque의 목적과 반대된다고 생각함...)
         그래서 section에 따라 분기처리한 후, 각 section에 맞게 cell을 deque하여 반환함.
         */
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
