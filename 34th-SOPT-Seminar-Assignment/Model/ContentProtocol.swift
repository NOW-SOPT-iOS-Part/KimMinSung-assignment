//
//  ContentProtocol.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/30.
//

import UIKit


protocol ContentProtocol {
    
    var name: String { get set }
    var contentID: UUID { get set }
    var type: ContentType { get set }
    
    var promotionalText: String? { get set }
    var imageURL: URL? { get set }
    var image: UIImage? { get set }
    var currentEpisode: Int? { get set }
    
    // 자체 인스턴스 속성인 imageURL을 이용하여 서버에서 이미지를 받아오는 함수
    // 아마 NetworkingManager가 있다면 함수 구현 시 해당 객체를 통해 가져올 듯
    // 여기서는 네트워크 통신이 없으므로 별도로 구현은 하지 않고 UIImage를 바로 반환하는 식으로 구현하였음.
    func getImageFromServer() -> UIImage?
    mutating func updateImage()
    
}


protocol LiveContentProtocol: ContentProtocol {
    
    var ratings: Double { get set }
    var channelName: String { get set }
    var ranking: Int? { get set }
    
    func getRatingsFromServer() -> Double?
    mutating func updateRatings()
    
}
