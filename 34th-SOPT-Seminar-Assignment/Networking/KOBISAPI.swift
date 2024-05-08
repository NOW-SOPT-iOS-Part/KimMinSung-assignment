//
//  KOBISAPI.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/07.
//

import Foundation
import Moya


enum KOBISAPI {
    case getMovieRanking(date: Date, number: Int? = nil)
}

// 13. Always remember to retain the provider somewhere: if you fail to do so, it will be released automatically, potentially before you receive any response. -> 싱글톤 객체로 구현

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
        let key = Bundle.main.KOBISAPIKey
        
        switch self {
        case .getMovieRanking(let date, let number):
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let dateInString = dateFormatter.string(from: date)
            
            return Moya.Task.requestParameters(
                parameters: ["key": key, "targetDt": dateInString, "itemPerPage": number ?? 10],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
