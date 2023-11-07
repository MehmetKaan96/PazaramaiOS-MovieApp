//
//  DetailViewControllerExtension.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 6.11.2023.
//

import Foundation
import UIKit

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorsCollectionViewCell.identifier, for: indexPath) as! ActorsCollectionViewCell
        
        cell.actorLabel.text = actorsArray[indexPath.row]
        cell.imageView.image = UIImage(named: "person")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.size.width * 0.4, height: 200)
    }
}

extension DetailViewController: MovieDetailViewModelDelegate {
    func configureDetail(movieDetail: MovieDetail) {
        DispatchQueue.main.async {
            self.movieDetail = movieDetail
            self.movieImageView.sd_setImage(with: URL(string:movieDetail.poster))
            self.releaseDateLabel.text = movieDetail.year
            self.movieLabel.text = movieDetail.title
            self.directorLabel.text = movieDetail.director
            self.infoLabel.text = movieDetail.plot
            self.backgroundImageView.sd_setImage(with: URL(string: movieDetail.poster))
            self.actorsArray = movieDetail.actors.components(separatedBy: ",")
            self.actorCollectionView.reloadData()
            if let rating = movieDetail.ratings.first?.value as? Double {
                self.rating.setRating(rating: rating)
            }
            
        }
    }
    
  @objc func toPreviousPage() {
      self.dismiss(animated: true)
    }
}
