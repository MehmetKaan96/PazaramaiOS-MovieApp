//
//  MainViewControllerExtension.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 6.11.2023.
//

import Foundation
import UIKit
import SDWebImage


//MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.imageView.sd_setImage(with: URL(string: moviesArray[indexPath.row].poster))
        cell.titleLabel.text = moviesArray[indexPath.row].title
        cell.releaseDateLabel.text = moviesArray[indexPath.row].year
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 20, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let service: MovieService = APIManager()
        let viewModel = MovieDetailViewModel(detailService: service)
        let vc = DetailViewController(viewModel: viewModel)
        vc.selectedMovieId = moviesArray[indexPath.row].imdbID
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            viewModel.fetchMovies(with: searchText)
        }
    }
}


//MARK: - MoviesViewModelDelegate

extension MainViewController: MoviesViewModelDelegate {
    func getMovies(movie: [Movie]) {
        DispatchQueue.main.async {
            moviesArray = movie
            self.updateCollection()
        }
    }
    
    func updateCollection() {
        if animationView == nil {
            animationView = .init(name: "noresult")
            animationView?.contentMode = .scaleAspectFit
            animationView?.loopMode = .loop
            animationView?.animationSpeed = 0.5
            animationView?.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(animationView!)
            animationView?.isHidden = true
        }
        
        if moviesArray.isEmpty {
            movieCollectionView.isHidden = true
            
            if let text = self.searchBar.text, !text.isEmpty, text.count > 2 {
                notFoundLabel.text = "No Movies / TV Shows Has Found."
                notFoundLabel.isHidden = false
                animationView.isHidden = false
                animationView.play()
                NSLayoutConstraint.activate([
                    animationView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
                    animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    animationView.heightAnchor.constraint(equalToConstant: 250),
                    
                    notFoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    notFoundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    notFoundLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                ])
            } else {
                notFoundLabel.text = "Search For Movies / TV Shows"
                
                notFoundLabel.isHidden = false
                animationView.stop()
                animationView.isHidden = true
                NSLayoutConstraint.activate([
                    notFoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    notFoundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    notFoundLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                ])
            }
        } else {
            movieCollectionView.isHidden = false
            notFoundLabel.isHidden = true
            animationView.stop()
            animationView.isHidden = true
        }
        movieCollectionView.reloadData()
    }
}
