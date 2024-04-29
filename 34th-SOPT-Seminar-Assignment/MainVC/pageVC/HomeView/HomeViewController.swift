//
//  HomeViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    let rootView = HomeView()
    
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        case 2:
            return 4
        case 3:
            return 6
        case 4:
            return 6
        case 5:
            return 4
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
            return headerView.withHeaderTitle("마술보다 더 신비로운 영화(신비로운 영화사전님")
        case 5:
            return headerView.withHeaderTitle("Quick VOD")
        default:
            return headerView
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let pagingCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomePosterPagingCell.reuseIdentifier,
            for: indexPath
        ) as? HomePosterPagingCell else { fatalError() }
        
        guard let verticalCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: homeVerticalRectCell.reuseIdentifier,
            for: indexPath
        ) as? homeVerticalRectCell else { fatalError() }
        
        guard let horizontalCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeHorizontalRectCell.reuseIdentifier,
            for: indexPath
        ) as? HomeHorizontalRectCell else { fatalError() }
        
        
        switch indexPath.section {
        case 0:
            return pagingCell
        case 1:
            return verticalCell
        case 2:
            return horizontalCell
        case 3:
            return verticalCell
        case 4:
            return verticalCell
        case 5:
            return horizontalCell
        default:
            fatalError()
        }
    }
}
