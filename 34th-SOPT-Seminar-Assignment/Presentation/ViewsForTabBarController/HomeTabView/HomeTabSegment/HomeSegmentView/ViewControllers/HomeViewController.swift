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
    
    // 다른 더미데이터들과는 달리 유일하게 네트워크 통신을 통해 이미지를 받아옴.
    var boxOfficeData: [BoxOfficeMovieProtocol] = []
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
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.updateBoxOfficeData(dateDistance: .yesterday)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDelegates()
    }
    
    
    private func updateBoxOfficeData(dateDistance: DateDistanceFromToday) {
        self.boxOfficeData = []
        APINetworkingManager.shared.getKOBISAPI(dateDistance: dateDistance) { [weak self] array in
            guard let self else { return }
            
            array.forEach { apiModel in
                var releaseDts = apiModel.openDate
                releaseDts = releaseDts.replacingOccurrences(of: "-", with: "")
                guard let movieCode = Int(apiModel.movieCode) else { fatalError("movieCode is not Int format") }
                guard let ranking = Int(apiModel.ranking) else { fatalError("ranking is not Int format") }
                guard let audienceAccumulated = Int(apiModel.audienceAccumulated) else { fatalError("audience count in not Int format") }
                
                APINetworkingManager.shared.getMoviePoster(title: apiModel.movieName, releaseDts: releaseDts) { [weak self] image in
                    guard let self else { return }
                    let movieContent = BoxOfficeContent(
                        movieName: apiModel.movieName,
                        movieCode: movieCode,
                        ranking: ranking,
                        audienceAccumulated: audienceAccumulated,
                        image: image
                    )
                    self.boxOfficeData.append(movieContent)
                    if self.boxOfficeData.count == 10 {
                        self.boxOfficeData = self.boxOfficeData.sorted{ $0.ranking < $1.ranking }
                        self.reloadCellsOnly(at: .boxOffice)
                    }
                }
            }
        }
    }
    
    
    /// self.rootView.collectionView의 dataSource에 self 할당
    ///
    /// collectionView의 delegate는 MainViewController 인스턴스에 할당하므로, 여기에서 delegate를 할당하지 않음.
    private func setDelegates() {
        self.rootView.collectionView.dataSource = self
    }
    
    private func reloadCellsOnly(at section: SectionKind) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let numberOfCells = self.rootView.collectionView.numberOfItems(inSection: section.rawValue)
            var indexPathsToReload: [IndexPath] = []
            for i in 0..<numberOfCells {
                indexPathsToReload.append(IndexPath(item: i, section: section.rawValue))
            }
            self.rootView.collectionView.reloadItems(at: indexPathsToReload )
        }
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
            /*
             일단 API에서 받아올 수 있는 최대 갯수가 10이라서 10으로 설정
             만약, 사용자 설정을 통해, 10보다 작은 수 만큼의 순위를 보여주게 하고 싶다면 UserDefaults 등으로 통해 구현할 수 있음.
             */
            return 10
        case 2:
            return self.mustSeeInTvingDummy.count
        case 3:
            return self.popularLiveDummy.count
        case 4:
            return self.paramountPlusDummy.count
        case 5:
            return self.magicalMoviewDummy.count
        case 6:
            return self.quickVODDummy.count
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 1:
            guard let boxOfficeHeaderView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeBoxOfficeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeBoxOfficeHeaderView else { fatalError() }
            
            boxOfficeHeaderView.delegate = self
            
            return boxOfficeHeaderView.withHeaderTitle("박스오피스")
            
        case 2:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeHeaderView else { fatalError() }
            
            return headerView.withHeaderTitle("티빙에서 꼭 봐야하는 콘텐츠")
            
        case 3:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeHeaderView else { fatalError() }
            
            return headerView.withHeaderTitle("인기 LIVE 채널")
            
        case 4:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeHeaderView else { fatalError() }
            
            return headerView.withHeaderTitle("1화 무료! 파라마운트+ 인기 시리즈")
            
        case 5:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeHeaderView else { fatalError() }
            
            return headerView.withHeaderTitle("마술보다 더 신비로운 영화(신비로운 영화사전님)")
            
        case 6:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeHeaderView else { fatalError() }
            
            return headerView.withHeaderTitle("Quick VOD")
            
        default:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeHeaderView else { fatalError() }
            
            return headerView
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let pagingCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomePosterPagingCell.reuseIdentifier,
                for: indexPath
            ) as? HomePosterPagingCell else { fatalError() }
            
            pagingCell.vcArray = self.homePosterVCsDummyData
            return pagingCell
            
        case 1:
            guard let boxOfficeCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeBoxOfficeCell.reuseIdentifier,
                for: indexPath
            ) as? HomeBoxOfficeCell else { fatalError() }
            
            boxOfficeCell.posterImageView.backgroundColor = .lightGray
            boxOfficeCell.rankingLabel.text = nil
            boxOfficeCell.mainTitleLabel.text = nil
            boxOfficeCell.subTitleLabel.text = nil
            boxOfficeCell.metricLabel.text = nil
            
            if self.boxOfficeData.count == 10 {
                boxOfficeCell.configureData(with: self.boxOfficeData[indexPath.item])
            }
            
            return boxOfficeCell
            
        case 2:
            guard let verticalCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeVerticalRectCell.reuseIdentifier,
                for: indexPath
            ) as? HomeVerticalRectCell else { fatalError() }
            
            verticalCell.configureData(with: self.mustSeeInTvingDummy[indexPath.item])
            return verticalCell
            
        case 3:
            guard let liveContentCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeLiveContentCell.reuseIdentifier,
                for: indexPath
            ) as? HomeLiveContentCell else { fatalError() }
            
            liveContentCell.configureData(with: self.popularLiveDummy[indexPath.item])
            return liveContentCell
            
        case 4:
            guard let verticalCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeVerticalRectCell.reuseIdentifier,
                for: indexPath
            ) as? HomeVerticalRectCell else { fatalError() }
            
            verticalCell.configureData(with: self.paramountPlusDummy[indexPath.item])
            return verticalCell
            
        case 5:
            guard let verticalCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeVerticalRectCell.reuseIdentifier,
                for: indexPath
            ) as? HomeVerticalRectCell else { fatalError() }
            
            verticalCell.configureData(with: self.magicalMoviewDummy[indexPath.item])
            return verticalCell
            
        case 6:
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


extension HomeViewController: BoxOfficeController {
    
    func changeBoxOfficeDate(to targetDateDistance: DateDistanceFromToday) {
        self.boxOfficeData = []
        self.reloadCellsOnly(at: .boxOffice)
        self.updateBoxOfficeData(dateDistance: targetDateDistance)
    }
    
}
