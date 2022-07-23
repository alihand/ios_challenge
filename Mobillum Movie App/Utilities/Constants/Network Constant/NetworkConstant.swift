//
//  NetworkConstant.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 21.07.2022.
//

import Foundation

public enum NetworkConstant {
    
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let apiKey = "39ddc72a475e8c7dfa606f2b0f72d304"
    static let image_base_url = "https://image.tmdb.org/t/p/w300"
    
    case NowPlayingMovies
    case UpComingMovies
    case MovieDetail
    
    var path: String {
        switch self {
        
        case .NowPlayingMovies:
            return "movie/now_playing"
            
        case .UpComingMovies:
            return "movie/upcoming"
        case .MovieDetail:
            return "movie/"
     
        }
    }
}
