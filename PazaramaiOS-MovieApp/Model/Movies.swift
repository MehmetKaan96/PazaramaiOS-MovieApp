//
//  Movies.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 7.11.2023.
//

import Foundation

struct MovieResult: Codable {
    let search: [Movie]?
    let totalResults, response, error: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}

// MARK: - Search
struct Movie: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}

var moviesArray: [Movie] = []
