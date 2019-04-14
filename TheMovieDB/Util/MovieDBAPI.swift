//
//  MovieDBAPI.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 26/01/19.
//  Copyright © 2019 SDvirtua Marketing Digital. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MovieDBAPI {
    
    
    
    static private let API_KEY = "c5850ed73901b8d268d0898a8a9d8bff"
    static private let MOVIE_LIST_URL = "https://api.themoviedb.org/3/search/movie?"
    static private let MOVIE_LIST_LAST = "https://api.themoviedb.org/3/movie/popular?"
    static private let MOVIE_DETAILS = "https://api.themoviedb.org/3/movie/"
    static private let MOVIE_GENRE = "https://api.themoviedb.org/3/genre/"
    

    let BASE_MOVIE_POSTER_URL = "https://image.tmdb.org/t/p/w500"
    static private let NOWPLAYING_FETCH_REQUEST = "NowPlayingMovies"
    static private let TOPRATED_FETCH_REQUEST = "TopRatedMovies"
    static private let NO_NETWORK_ERROR = "Please check connectivity to network."
    static private let MOVIE_FETCH_FAIL_ALERT_TITLE = "Error"
    
    
    //Carrega Filmes
    class func loadMovies(title: String?, page : Int, onComplete: @escaping (MoviesInfo?) -> Void) {
        
        let query: String
        let url: String
        
        
        if let name = title, !name.isEmpty {
            query = "query=\(name.replacingOccurrences(of: " ", with: ""))&"
            url = MOVIE_LIST_URL + "api_key=\(API_KEY)&" + query + "page=\(page)"
            print(url)
            
        } else {
            url = MOVIE_LIST_LAST + "api_key=\(API_KEY)&page=\(page)"
            print(url)
        }
        
        Alamofire.request(url).responseObject { (response: DataResponse<MoviesInfo>) in
            onComplete(response.result.value)
            
        }

    }
    
    //Carrega Generos
    class func loadGenres(movie_id: [Int] = [], onComplete: @escaping (MoviesDetail?) -> Void) {
        
        let url: String
        url = MOVIE_DETAILS + "\(movie_id)" + "?api_key=\(API_KEY)"
        
        Alamofire.request(url).responseObject { (response: DataResponse<MoviesDetail>) in
            onComplete(response.result.value)
            
        }
        
    }
    
}
