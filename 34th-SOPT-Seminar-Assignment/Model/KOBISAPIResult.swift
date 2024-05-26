//
//  MovieNetworkingResult.swift
//  KOBISAPI
//
//  Created by 김민성 on 2024/05/09.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? JSONDecoder().decode(Movie.self, from: jsonData)

import Foundation

// MARK: - MovieNetworkingResult
struct KOBISAPIResult: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType: String // 박스오피스 종류
    let showRange: String // 박스오피스 조회 일자
    let dailyBoxOfficeList: [DailyBoxOfficeMovie]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeMovie: Codable {
    let rankingNumber: String // 순번
    let ranking: String // 해당 일자의 박스오피스 순위
    let rankIntensity: String // 전일 대비 순위의 증감분
    let rankOldAndNew: RankOldAndNew.RawValue // 랭킹에 신규진입여부
    let movieCode: String // 영화의 대표코드
    let movieName: String // 영화명(국문)
    let openDate: String // 영화의 개봉일 ("yyyy-MM-dd" 형식)
    let salesAmount: String // 해당 일의 매출액
    let salesShare: String // 해당 일자 상영작의 매출총액 대비 해당 영화의 매출비율 출력
    let salesIntensity: String // 전일 대비 매출액 증감분
    let salesChange: String // 전일 대비 매출액 증감 비율
    let salesAccumulated: String // 누적 매출액
    let audienceCount: String // 해당 일의 관객 수
    let audienceIntensity: String // 전일 대비 관객 수 증감분
    let audienceChange: String // 전일 대비 관객 수 증감 비율
    let audienceAccumulated: String // 누적 관객수
    let screenCount: String // 해당 일자에 상영한 스크린 수
    let showingCount: String // 해당 일자에 상영된 횟수

    enum CodingKeys: String, CodingKey {
        case rankingNumber = "rnum"
        case ranking = "rank"
        case rankIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesIntensity = "salesInten"
        case salesChange = "salesChange"
        case salesAccumulated = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulated = "audiAcc"
        case screenCount = "scrnCnt"
        case showingCount = "showCnt"
    }
}

enum RankOldAndNew: String, Codable {
    case old = "OLD"
    case new = "NEW"
}


extension DailyBoxOfficeMovie {
    static func dummyData() -> DailyBoxOfficeMovie {
        self.init(
            rankingNumber: "1",
            ranking: "1",
            rankIntensity: "0",
            rankOldAndNew: "OLD",
            movieCode: "",
            movieName: "20228797", //범죄도시4 코드임.
            openDate: "2000-01-01",
            salesAmount: "0",
            salesShare: "0.0",
            salesIntensity: "0",
            salesChange: "0.0",
            salesAccumulated: "0",
            audienceCount: "0",
            audienceIntensity: "0",
            audienceChange: "0.0",
            audienceAccumulated: "0",
            screenCount: "0",
            showingCount: "0"
        )
    }
}
