//
//  PazaramaiOS_MovieAppTests.swift
//  PazaramaiOS-MovieAppTests
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import XCTest
@testable import PazaramaiOS_MovieApp

final class PazaramaiOS_MovieAppTests: XCTestCase {
    
    private var movieViewModel: MoviesViewModel!
    private var movieDetailViewModel: MovieDetailViewModel!
    
    private var movieService: MockMovieService!
    private var movieViewModelOutput: MockMovieViewModelDelegate!
    private var movieDetailViewModelOutput: MockMovieDetailViewModelDelegate!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        movieService = MockMovieService()
        movieViewModel = MoviesViewModel(movieService: movieService)
        movieViewModelOutput = MockMovieViewModelDelegate()
        movieViewModel.delegate = movieViewModelOutput
        
        movieDetailViewModel = MovieDetailViewModel(detailService: movieService)
        movieDetailViewModelOutput = MockMovieDetailViewModelDelegate()
        movieDetailViewModel.delegate = movieDetailViewModelOutput
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testFetchMovies_WhenAPISuccess_ShowsResult() throws {
        let mockMovieResult = Movie(title: "Batman Begins", year: "2005", imdbID: "tt0372784", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")
        let mockMovie = MovieResult(search: [mockMovieResult], totalResults: nil, response: nil, error: nil)
        movieService.fetchMoviesMockResult = .success(mockMovie.search!)
        movieViewModel.fetchMovies(with: "Batman Begins")
        XCTAssertEqual(movieViewModelOutput.movies.count, 1)
        XCTAssertEqual(movieViewModelOutput.movies.last?.name, "Batman Begins")
        XCTAssertEqual(movieViewModelOutput.movies.last?.year, "2005")
    }
    
    func testFetchMovieDetail_WhenAPISuccess_ShowResult() throws {
        let mockMovieDetail = MovieDetail(title: "Batman Begins", year: "2005", rated: "PG-13", released: "15 Jun 2005", runtime: "140 min", genre: "Action, Crime, Drama", director: "Christopher Nolan", writer: "Bob Kane, David S. Goyer, Christopher Nolan", actors: "Christian Bale, Michael Caine, Ken Watanabe", plot: "After witnessing his parents' death, Bruce learns the art of fighting to confront injustice. When he returns to Gotham as Batman, he must stop a secret society that intends to destroy the city.", language: "English, Mandarin", country: "United States, United Kingdom", awards: "Nominated for 1 Oscar. 14 wins & 79 nominations total", poster: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg", ratings: [Rating(source: "Internet Movie Database", value: "8.2/10")], metascore: "70", imdbRating: "8.2", imdbVotes: "1,540,461", imdbID: "tt0372784", type: "movie", dvd: "09 Sep 2009", boxOffice: "$206,863,479", production: "N/A", website: "N/A", response: "True")
        movieService.fetchMovieDetailMockResult = .success(mockMovieDetail)
        movieDetailViewModel.fetchDetail(with: "tt0372784")
        XCTAssertEqual(movieDetailViewModelOutput.movieDetails.last?.name, "Batman Begins")
        XCTAssertEqual(movieDetailViewModelOutput.movieDetails.last?.year, "2005")
        XCTAssertEqual(movieDetailViewModelOutput.movieDetails.last?.rated, "PG-13")
        XCTAssertEqual(movieDetailViewModelOutput.movieDetails.last?.runtime, "140 min")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    class MockMovieService: MovieService {
        
        var fetchMoviesMockResult: Result<[PazaramaiOS_MovieApp.Movie],PazaramaiOS_MovieApp.NetworkError>?
        
        var fetchMovieDetailMockResult: Result<PazaramaiOS_MovieApp.MovieDetail, PazaramaiOS_MovieApp.NetworkError>?
        
        func fetchMovies(with string: String, completion: @escaping (Result<[PazaramaiOS_MovieApp.Movie], PazaramaiOS_MovieApp.NetworkError>) -> Void) {
            if let result = fetchMoviesMockResult {
                completion(result)
            }
        }
        
        func fetchMovieDetail(with id: String, completion: @escaping (Result<PazaramaiOS_MovieApp.MovieDetail, PazaramaiOS_MovieApp.NetworkError>) -> Void) {
            if let result = fetchMovieDetailMockResult {
                completion(result)
            }
        }
        
        
    }
    
    class MockMovieViewModelDelegate: MoviesViewModelDelegate {
        var movies: [(name: String, year: String, id: String,type: TypeEnum ,poster: String)] = []
        
        func getMovies(movie: [PazaramaiOS_MovieApp.Movie]) {
            if let name = movie.last?.title,
               let year = movie.last?.year,
               let id = movie.last?.imdbID,
               let type = movie.last?.type,
               let image = movie.last?.poster{
                movies.append((name: name, year: year, id: id,type: type ,poster: image))
            }
        }
    }
    
    class MockMovieDetailViewModelDelegate: MovieDetailViewModelDelegate {
        var movieDetails: [(name: String, year: String, rated: String, released: String, runtime: String, genre: String, director: String, writer: String, actors: String, plot: String, language: String, country: String, awards: String, poster: String ,ratings: [Rating], metascore: String, imdbRating: String, imdbVotes: String, imdbID: String, type: String, dvd: String, boxOffice: String, production: String, website: String, response: String)] = []
        
        func configureDetail(movieDetail: PazaramaiOS_MovieApp.MovieDetail) {
            movieDetails.append((name: movieDetail.title, year: movieDetail.year, rated: movieDetail.rated, released: movieDetail.released, runtime: movieDetail.runtime, genre: movieDetail.genre, director: movieDetail.director, writer: movieDetail.writer, actors: movieDetail.actors, plot: movieDetail.plot, language: movieDetail.language, country: movieDetail.country, awards: movieDetail.awards, poster: movieDetail.poster,ratings: movieDetail.ratings, metascore: movieDetail.metascore, imdbRating: movieDetail.imdbRating, imdbVotes: movieDetail.imdbVotes, imdbID: movieDetail.imdbID, type: movieDetail.type, dvd: movieDetail.dvd, boxOffice: movieDetail.boxOffice, production: movieDetail.production, website: movieDetail.website, response: movieDetail.response))
        }
        
        
    }

}
