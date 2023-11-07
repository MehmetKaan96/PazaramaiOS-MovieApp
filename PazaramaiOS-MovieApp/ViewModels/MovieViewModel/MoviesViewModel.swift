//
//  MoviesViewModel.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 7.11.2023.
//

import Foundation


class MoviesViewModel {
    
    private let movieService: MovieService
    
    var delegate: MoviesViewModelDelegate?
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func fetchMovies(with name: String) {
        movieService.fetchMovies(with: name) { result in
            switch result {
            case .success(let movies):
                self.delegate?.getMovies(movie: movies)
            case .failure(let error):
                self.delegate?.getMovies(movie: [Movie]())
        }
        }
    }
}
