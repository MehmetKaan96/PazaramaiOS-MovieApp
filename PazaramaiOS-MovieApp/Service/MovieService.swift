//
//  APIService.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 7.11.2023.
//

import Foundation

protocol MovieService {
    func fetchMovies(with string: String, completion: @escaping(Result<[Movie], NetworkError>) -> Void)
    
    func fetchMovieDetail(with id: String, completion: @escaping(Result<MovieDetail, NetworkError>) -> Void)
}
