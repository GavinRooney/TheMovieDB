//
//  Movie.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

struct Movie: Codable {

    let voteCount: Int?
    let id: Int?
    let video: Bool?
    let voteAverage: Float?
    let popularity: Float?
    let adult: Bool?
    
    let title: String?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        
        case popularity
        case adult
        case title
        case id
        case video
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? nil
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? nil
        self.video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? nil
        self.voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage) ?? nil
        self.popularity = try container.decodeIfPresent(Float.self, forKey: .popularity) ?? nil
        self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? nil
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? nil
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? nil
        self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? nil
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? nil
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? nil
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? nil
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? nil
        self.genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? nil
    }
}
