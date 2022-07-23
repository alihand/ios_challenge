//
//  Service.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 23.07.2022.
//

import Foundation
import Alamofire

protocol ServicesProtocol {
    func fetchUpComingMovies(withpage:Int, onSuccess: @escaping (UpComingMovieModel?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchNowPlayingMovies(onSuccess: @escaping (NowPlayingMovieModel?) -> Void, onError: @escaping (AFError) -> Void)
    func getMovieDetail(movieID: Int, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Service: ServicesProtocol {
    func fetchUpComingMovies(withpage:Int,onSuccess: @escaping (UpComingMovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        NetworkManager.shared.fetch(path: NetworkConstant.baseUrl + NetworkConstant.UpComingMovies.path + "?api_key=\(NetworkConstant.apiKey)&page=\(withpage)") { (response: UpComingMovieModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchNowPlayingMovies(onSuccess: @escaping (NowPlayingMovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        NetworkManager.shared.fetch(path: NetworkConstant.baseUrl + NetworkConstant.NowPlayingMovies.path + "?api_key=\(NetworkConstant.apiKey)") { (response: NowPlayingMovieModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    func getMovieDetail(movieID: Int, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void) {
        NetworkManager.shared.fetch(path: NetworkConstant.baseUrl + NetworkConstant.MovieDetail.path + "\(movieID)" + "?api_key=\(NetworkConstant.apiKey)") { (response: MovieDetailModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}

final class ServiceCaller{
    
    private var service: ServicesProtocol
    
    init(service: ServicesProtocol) {
        self.service = service
    }
    
    func fetchUpComingMovies(withpage:Int, onSuccess: @escaping (UpComingMovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        self.service.fetchUpComingMovies(withpage: withpage) { movie in
            guard let movie = movie else {
                onSuccess(nil)
                return
            }
            onSuccess(movie)
        } onError: { error in
            onError(error)
        }
        
    }
    
    func fetchNowPlayingMovies(onSuccess: @escaping (NowPlayingMovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        self.service.fetchNowPlayingMovies { movie in
            guard let movie = movie else {
                onSuccess(nil)
                return
            }
            onSuccess(movie)
        } onError: { error in
            onError(error)
        }
        
    }
    
    func getMovieDetail(movieID: Int, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void) {
        self.service.getMovieDetail(movieID: movieID) { movieDetail in
            guard let movieDetail = movieDetail else {
                onSuccess(nil)
                return
            }
            onSuccess(movieDetail)
        } onError: { error in
            onError(error)
        }
    }
}
