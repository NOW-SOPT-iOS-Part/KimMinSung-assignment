//
//  NetworkingManager.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/09.
//

import UIKit

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    private init() { }
    
    
    func getImage(using URL: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: URL) { data, response, error in
            guard let data, error == nil else { fatalError() }
            print(response?.suggestedFilename ?? URL.lastPathComponent)
            guard let image = UIImage(data: data) else { fatalError("data converting into UIImage failed") }
            completion(image)
        }
    }
    
    
}
