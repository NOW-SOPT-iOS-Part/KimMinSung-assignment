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
    
}


protocol LiveContentProtocol: ContentProtocol {
    
    var ratings: Double { get set }
    var channelName: String { get set }
    var ranking: Int? { get set }
    
    func getRatingsFromServer() -> Double?
    mutating func updateRatings()
    
}


protocol BoxOfficeMovieProtocol {
    
    var movieName: String { get }
    var movieCode: Int { get }
    var ranking: Int { get }
    
    var imageURL: URL? { get set }
    var image: UIImage? { get set }
    
}
