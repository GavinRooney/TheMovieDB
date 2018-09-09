//
//  Movie.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

    
struct Movie: Codable {

    let budget: Int?
    let runtime: Int?
    let revenue: Int?
    let voteCount: Int?
    let id: Int?
    let video: Bool?
    let voteAverage: Float?
    let popularity: Float?
    let adult: Bool?
    let imdbID: String?
    let title: String?
    let homepage: String?
    let tagline: String?
    let status: String?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case imdbID = "imdb_id"
        
        case overview
        case popularity
        case runtime
        case adult
        case title
        case tagline
        case id
        case video
        case status
        case budget
        case homepage
        case revenue
        case genres
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? nil
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime) ?? nil
        self.budget = try container.decodeIfPresent(Int.self, forKey: .budget) ?? nil
        self.revenue = try container.decodeIfPresent(Int.self, forKey: .revenue) ?? nil
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? nil
        self.video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? nil
        self.voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage) ?? nil
        self.popularity = try container.decodeIfPresent(Float.self, forKey: .popularity) ?? nil
        self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? nil
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? nil
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? nil
        self.homepage = try container.decodeIfPresent(String.self, forKey: .homepage) ?? nil
        self.imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID) ?? nil
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline) ?? nil
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? nil
        self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? nil
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? nil
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? nil
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? nil
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? nil
        self.genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? nil
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? nil
        
    }
}
