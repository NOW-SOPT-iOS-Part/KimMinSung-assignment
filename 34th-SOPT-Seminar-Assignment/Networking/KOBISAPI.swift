//
//  KOBISAPI.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/07.
//

import Foundation
import Moya

enum KOBISAPI {
    case getMovieRanking(targetDate: String, number: Int = 10)
}

extension KOBISAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://www.kobis.or.kr")!
    }
    
    var path: String {
        switch self {
        case .getMovieRanking:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieRanking:
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
            
        }
    }
    
    var headers: [String : String]? { return nil }
    
}
