//
//  MovieDetailModel.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 21.07.2022.
//

import Foundation

struct MovieDetailModel: Codable {
    let imdbID, title, overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case imdbID = "imdb_id"
        case title = "title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
