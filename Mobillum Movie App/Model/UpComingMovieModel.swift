//
//  UpComingMovieModel.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 21.07.2022.
//

import Foundation

struct UpComingMovieModel: Codable {
    let results: [UpComingMovieModelResult]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct UpComingMovieModelResult: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title = "title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
