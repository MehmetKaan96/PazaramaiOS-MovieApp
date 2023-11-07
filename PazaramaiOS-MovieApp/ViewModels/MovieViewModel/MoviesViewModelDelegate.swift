//
//  MoviesViewModelDelegate.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 7.11.2023.
//

import Foundation

protocol MoviesViewModelDelegate {
    
    func getMovies(movie: [Movie])
    
}
