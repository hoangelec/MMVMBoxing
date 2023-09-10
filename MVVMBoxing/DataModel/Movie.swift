//
//  Movie.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 09/09/2023.
//

struct Movie: Decodable {
    var title: String
    var overview: String
    var releaseDate: String
    var posterPath: String?
    
    enum CodingKeys: String, CodingKey {
            case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
