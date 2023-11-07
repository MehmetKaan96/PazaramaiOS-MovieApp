//
//  MainViewController.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    
    let manager = APIManager()
            
    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "Search for the movie"
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .default
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    internal let movieCollectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let notFoundLabel: UILabel = {
       let label = UILabel()
        label.text = "Movie / TV Series Not Found."
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
        
    let viewModel: MoviesViewModel
    
    var animationView: LottieAnimationView!
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchMovies(with: "batman")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(movieCollectionView)
        view.addSubview(notFoundLabel)
        searchBar.delegate = self
        
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.backgroundColor = .systemGray6
                
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            movieCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}
