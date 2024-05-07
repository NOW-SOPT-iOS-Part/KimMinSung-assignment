//
//  DummyDataMaker.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/29.
//

import UIKit

enum SectionKind: CaseIterable {
    case homePoster
    case mustSeeInTving
    case popularLiveChannel
    case paramountPlus
    case magicalMovie
    case quickVOD
}

class DummyDataMaker {
    
    static let shared = DummyDataMaker.init()
    private init() { }
    
    
    /*
     네트워크 통신을 하지 않기 때문에, 코드를 통해 Contents 인스턴스를 생성하여 더미 데이터 제작함.
     만약 네트워크 통신을 이용한다면 content의 고유 ID를 통해 서버에서 Cotent 정보를 가져올 듯.
     */
    
    func makeContentsDummy(kind: SectionKind) -> [ContentProtocol] {
        switch kind {
        case .homePoster:
            return self.homePosters
        case .mustSeeInTving:
            return self.mustSeeInTvings
        case .popularLiveChannel:
            return self.popularLiveChannels
        case .paramountPlus:
            return self.paramountPlusContents
        case .magicalMovie:
            return self.magicalMovies
        case .quickVOD:
            return self.quickVODs
        }
    }
    
    
    private var homePosters: [Content] {
        
        //var vcArray: [HomePosterViewController] = []
        
        let contentsArray = [
            Content(
                name: "아워게임",
                type: .documentary,
                promotionalText: "[7화 공개🔔] 28년만의 우승을 노린다!\n2022년 LG트윈스의 피, 땀, 눈물 그 모든 이야기",
                image: .promotionalPosterDocumentaryOurGame
            ),
            Content(
                name: "패밀리",
                type: .series,
                promotionalText: "본격 가족사수 첩보 코미디 시작!\n평번한 가족의 아슬아슬한 이중생활",
                image: .promotionalPosterSeriesFamily
            ),
            Content(
                name: "최강야구",
                type: .series,
                promotionalText: "사상 최강 야구팀이 생겼다!\n야구 강팀이 펼치는 양보없는 대결",
                image: .promotionalPosterEntertainmentACleenSweep
            ),
            Content(
                name: "너의 이름은",
                type: .entertainment,
                promotionalText: "\"우리, 서로 몸이 바뀐 거야?!\"\n만난 적 없는 두 사람의 만남.\n운명의 톱니바퀴가, 지금 움직이기 시작한다.",
                image: .promotionalPosterMovieYourName
            ),
            Content(
                name: "해리포터와 죽음의 성물: 파트2",
                type: .documentary,
                promotionalText: "이제, 모든 것이 끝난다!\n해리포터의 마지막 시리즈",
                image: .promotionalPosterMovieHarryPotter7Part2
            )
        ]
        
        return contentsArray
    }
    
    
    private var mustSeeInTvings: [Content] {
        let contentsArray = [
            Content(name: "시그널", type: .series, image: .posterSeriesSignal),
            Content(name: "보이즈플래닛", type: .entertainment, image: .posterEntertainmentBoysPlanet),
            Content(name: "그리스: 라이즈 오브 핑크 레이디스", type: .movie, image: .posterParamountPlusGreaseROTPL),
            Content(name: "보라! 데보라", type: .series, image: .posterSeriesTrueToLove),
            Content(name: "환승연애3", type: .entertainment, image: .posterEntertainmentEXchange3),
            Content(name: "아워게임", type: .documentary, image: .posterDocumentaryOurGame)
        ]
        return contentsArray
    }
    
    
    private var popularLiveChannels: [LiveContent] {
        let contentsArray = [
            LiveContent(
                name: "범죄도시4",
                type: .movie,
                image: .thumbnailMovieOCNMoviesTheRoundup,
                ratings: 71.2,
                channelName: "OCN Movies",
                ranking: 1
            ),
            LiveContent(
                name: "5화",
                type: .entertainment,
                image: .thumbnailEntertainmentCHNJTTW8Ep5,
                ratings: 15.3,
                channelName: "CH.신서유기8",
                ranking: 2
            ),
            LiveContent(
                name: "보이즈 플래닛 12화",
                type: .concert,
                image: .thumbnailEntertainmentMnetBoysPlanet,
                ratings: 5.9,
                channelName: "Mnet",
                ranking: 3
            ),
            LiveContent(
                name: "마우스 3화",
                type: .series,
                image: .thumbnailSeriesTvnMouse,
                ratings: 4.5,
                channelName: "tvN",
                ranking: 4
            ),
            LiveContent(
                name: "뉴스라이브",
                type: .news,
                image: .thumbnailNewsYtnNewslive,
                ratings: 3.9,
                channelName: "YTN",
                ranking: 5
            ),
        ]
        return contentsArray
    }
    
    
    private var paramountPlusContents: [Content] {
        let contentsArray = [
            Content(name: "그리스: 라이즈 오브 핑크 레이디스", type: .movie, image: .posterParamountPlusGreaseROTPL),
            Content(name: "옐로우 재킷", type: .series, image: .posterParamountPlusYellowjackets),
            Content(name: "더 그레이트 시즌1", type: .series, image: .posterParamountPlusTheGreatSeason1),
            Content(name: "헤일로 시즌2", type: .series, image: .posterParamountPlusHaloSeason2),
            Content(name: "네모바지 스폰지밥 시즌13", type: .series, image: .posterParamountPlusSpongeBobSquarepants),
            Content(name: "너클즈 (자막)", type: .series, image: .posterParamountPlusKnucklesSubSeason1)
        ]
        return contentsArray
    }
    
    
    private var magicalMovies: [Content] {
        let contentsArray = [
            Content(name: "해리포터와 마법사의 돌", type: .movie, image: .posterMovieHarryPotter01),
            Content(name: "반지의 제왕", type: .movie, image: .posterMovieLordOfTheRings),
            Content(name: "그리스: 라이즈 오브 핑크 레이디스", type: .movie, image: .posterParamountPlusGreaseROTPL),
            Content(name: "라라랜드", type: .movie, image: .posterMovieLaLaLand),
            Content(name: "웡카", type: .movie, image: .posterMovieWonka),
            Content(name: "신과함께", type: .movie, image: .posterMovieAlongWithTheGods)
        ]
        return contentsArray
    }
    
    
    private var quickVODs: [Content] {
        let contentsArray = [
            Content(name: "눈물의 여왕", type: .movie, image: .thumbnailSeriesQueenOfTears, currentEp: 3),
            Content(name: "태어난 김에 세계일주", type: .movie, image: .thumbnailEntertainentAdventureByAccident, currentEp: 2),
            Content(name: "최강야구", type: .series, image: .thumbnailEntertainmentACleenSweep, currentEp: 3),
            Content(name: "그해 우리는", type: .movie, image: .thumbnailSeriesOurBelovedSummer, currentEp: 7),
            Content(name: "도시어부", type: .movie, image: .thumbnailEntertainmentTheFishermanAndTheCity, currentEp: 5)
        ]
        return contentsArray
    }
    
}
