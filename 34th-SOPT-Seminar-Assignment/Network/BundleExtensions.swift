//
//  BundleExtensions.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/07.
//

import Foundation


extension Bundle {
    
    /// SecureData plist에 접근해서 API Key 반환
    var KOBISAPIKey: String {
        guard let filePathURL = Bundle.main.url(forResource: "SecureData", withExtension: "plist") else { fatalError() }
        do {
            let plistDict2 = try NSDictionary(contentsOf: filePathURL, error: ())
            guard let apiKey = plistDict2.object(forKey: "KOBISAPIKey") as? String else { fatalError() }
            return apiKey
            
        } catch {
            fatalError()
        }
    }
    
    var KMDBAPIKey: String {
        guard let filePathURL = Bundle.main.url(forResource: "SecureData", withExtension: "plist") else { fatalError() }
        do {
            let plistDict2 = try NSDictionary(contentsOf: filePathURL, error: ())
            guard let apiKey = plistDict2.object(forKey: "KMDBAPIKey") as? String else { fatalError() }
            return apiKey
            
        } catch {
            fatalError()
        }
    }
    
}
