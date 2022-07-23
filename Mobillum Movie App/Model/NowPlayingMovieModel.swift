//
//  NowPlayingMovieModel.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 21.07.2022.
//

import Foundation

struct NowPlayingMovieModel: Codable {
    let results: [NowPlayingMovieModelResult]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct NowPlayingMovieModelResult: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title = "title"
        case posterPath = "poster_path"
    }
}
