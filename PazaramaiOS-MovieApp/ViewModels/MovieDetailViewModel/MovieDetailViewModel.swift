//
//  MovieDetailViewModel.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 7.11.2023.
//

import Foundation

class MovieDetailViewModel {
    private let detailService: MovieService
    
    var delegate: MovieDetailViewModelDelegate?
    
    init(detailService: MovieService) {
        self.detailService = detailService
    }
    
    func fetchDetail(with id: String) {
        detailService.fetchMovieDetail(with: id) { result in
            switch result {
            case .success(let detail):
                self.delegate?.configureDetail(movieDetail: detail)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
