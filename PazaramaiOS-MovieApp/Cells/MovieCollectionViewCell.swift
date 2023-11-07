//
//  MovieCollectionViewCell.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 6.11.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "backgroundImage1")
        imageView.layer.cornerRadius = 10
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Spider Man"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            return label
        }()

        let releaseDateLabel: UILabel = {
            let label = UILabel()
            label.text = "2022"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .gray
            return label
        }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
            
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.layer.cornerRadius = 10
            contentView.backgroundColor = .white
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
            contentView.layer.shadowRadius = 4
            contentView.layer.shadowOpacity = 0.2

            contentView.layer.borderColor = UIColor.black.cgColor
            contentView.layer.borderWidth = 0.5
            
            addSubview(imageView)
            addSubview(titleLabel)
            addSubview(releaseDateLabel)
            addSubview(typeLabel)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor,constant: -10),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -250),
                imageView.heightAnchor.constraint(equalToConstant: 150),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 40),
                titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                
                releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                releaseDateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                
                typeLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 5),
                typeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                
            ])
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}
