//
//  ContentModel.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/29.
//

import UIKit

enum ContentType {
    case movie
    case series
    case documentary
    case concert
    case entertainment
    case education
    case news
}




struct Content: ContentProtocol {
    
    var name: String
    var contentID: UUID
    var type: ContentType
    
    var promotionalText: String? = nil
    var imageURL: URL? = nil
    var image: UIImage? = nil
    
    // 시리즈물일 경우, 현재 시청중인 화
    var currentEpisode: Int? = nil
    
    init(name: String, type: ContentType, promotionalText: String? = nil, image: UIImage? = nil, currentEp episode: Int? = nil) {
        self.name = name
        self.contentID = UUID()
        self.type = type
        self.promotionalText = promotionalText
        self.image = image
        self.currentEpisode = episode
    }
    
    func getImageFromServer() -> UIImage? {
        return .posterSeriesSignal
    }
    
    mutating func updateImage() {
        self.image = getImageFromServer()
    }
}








struct LiveContent: LiveContentProtocol {
    
    var name: String
    var contentID: UUID
    var type: ContentType
    
    var promotionalText: String? = nil
    var imageURL: URL? = nil
    var image: UIImage? = nil
    
    // 시리즈물일 경우, 현재 시청중인 화
    var currentEpisode: Int? = nil
    
    var ratings: Double = 0
    var channelName: String
    var ranking: Int? = nil
    
    init(
        name: String,
        type: ContentType,
        promotionalText: String? = nil,
        image: UIImage? = nil,
        imageURL: URL? = nil,
        ratings: Double = 0,
        channelName: String,
        ranking: Int? = nil
    ) {
        self.name = name
        self.contentID = UUID()
        self.type = type
        self.promotionalText = promotionalText
        self.image = image
        self.imageURL = imageURL
        self.ratings = ratings
        self.channelName = channelName
        self.ranking = ranking
    }
    
    func getImageFromServer() -> UIImage? {
        return nil
    }
    
    mutating func updateImage() {
        self.image = self.getImageFromServer()
    }
    
    func getRatingsFromServer() -> Double? {
        // 아마 네트워크 통신을 통해 정해진 값을 받아올 것임.
        // 여기서는 nil을 반환
        return nil
    }
    
    mutating func updateRatings() {
        guard let newRatings = self.getRatingsFromServer() else { return }
        self.ratings = newRatings
    }
}















