//
//  StarRatingView.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 6.11.2023.
//

import UIKit

class StarRatingView: UIView {
    
    private var starImageViews: [UIImageView] = []
    private var rating: Double = 0.0
    private let maxRating: Double = 10.0
    private let starCount: Int = 5
    
    private var ratingView: UIView!
    
    init(frame: CGRect, rating: Double) {
        super.init(frame: frame)
        self.rating = rating
        setupStarRatingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupStarRatingView() {
        let starSize = frame.size.height
        let spacing: CGFloat = 5.0
        let totalWidth = (starSize * CGFloat(starCount)) + (spacing * CGFloat(starCount - 1))
        
        for i in 0..<starCount {
            let starImageView = UIImageView()
            let starFrame = CGRect(x: CGFloat(i) * (starSize + spacing), y: 0, width: starSize, height: starSize)
            starImageView.frame = starFrame
            starImageView.contentMode = .scaleAspectFit
            starImageView.clipsToBounds = true
            starImageView.image = UIImage(systemName: i < Int(rating) ? "star.fill" : "star")
            starImageViews.append(starImageView)
            addSubview(starImageView)
        }
        
        let ratingWidth = CGFloat(rating / maxRating) * totalWidth
        ratingView = UIView(frame: CGRect(x: 0, y: 0, width: ratingWidth, height: frame.size.height))
        ratingView.clipsToBounds = true
        for i in 0..<starCount {
            starImageViews[i].contentMode = .scaleAspectFit
            ratingView.addSubview(starImageViews[i])
        }
        addSubview(ratingView)
    }
    
    func setRating(rating: Double) {
        self.rating = rating
        
        let ratingWidth = CGFloat(rating / maxRating) * (frame.size.height * CGFloat(starCount))
        
        let ratingFrame = CGRect(x: 0, y: 0, width: ratingWidth, height: frame.size.height)
        ratingView.frame = ratingFrame
        
        for i in 0..<starCount {
            starImageViews[i].image = UIImage(systemName: i < Int(rating) ? "star.fill" : "star")
        }
    }
    
}
