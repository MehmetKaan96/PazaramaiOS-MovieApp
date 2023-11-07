//
//  APIManager.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 7.11.2023.
//

import Foundation

class APIManager: MovieService {
    func fetchMovies(with string: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        if let urlString = URL(string: Constants.baseURL + Constants.API_KEY + "&s=\(string)") {
            URLSession.shared.dataTask(with: urlString) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed))
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MovieResult.self, from: data)
                    if let movies = decodedData.search {
                        completion(.success(movies))
                    } else {
                        completion(.success([]))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            }.resume()
        }
    }
    
    func fetchMovieDetail(with id: String, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        if let urlString = URL(string: Constants.baseURL + Constants.API_KEY + "&i=\(id)") {
            URLSession.shared.dataTask(with: urlString, completionHandler: { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed))
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MovieDetail.self, from: data)
                    completion(.success(decodedData))
                } catch  {
                    completion(.failure(.decodeError))
                }
            }).resume()
        }
    }
    
    
}
