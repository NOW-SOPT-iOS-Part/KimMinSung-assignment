//
//  KOBISAPI.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/07.
//

import Foundation
import Moya

enum MoyaTargetType {
    case getMovieRanking(targetDate: String, number: Int = 10)
    case getKMDBAPI(title: String, releaseDts: String)
}

extension MoyaTargetType: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getMovieRanking:
            return URL(string: "http://www.kobis.or.kr")!
        case .getKMDBAPI:
            return URL(string: "http://api.koreafilm.or.kr")!
        }
    }
    
    var path: String {
        switch self {
        case .getMovieRanking:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .getKMDBAPI:
            return "/openapi-data2/wisenut/search_api/search_json2.jsp"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieRanking, .getKMDBAPI:
            return Moya.Method.get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMovieRanking(let targetDateString, let number):
            let key = Bundle.main.KOBISAPIKey
            return Moya.Task.requestParameters(
                parameters: ["key": key, "targetDt": targetDateString, "itemPerPage": "\(number)"],
                encoding: URLEncoding.queryString
            )
            
        case .getKMDBAPI(title: let title, releaseDts: let releaseDts):
            let key = Bundle.main.KMDBAPIKey
            return Moya.Task.requestParameters(
                parameters: ["collection": "kmdb_new2", "ServiceKey": key, "title": title, "releaseDts": releaseDts],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? { return nil }
    
}
