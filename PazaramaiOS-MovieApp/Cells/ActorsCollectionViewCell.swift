//
//  ActorsCollectionViewCell.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 6.11.2023.
//

import UIKit

class ActorsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ActorsCollectionViewCell"
    
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "person")
        imageView.layer.cornerRadius = 10
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let actorLabel: UILabel = {
            let label = UILabel()
            label.text = "Arnold Schwarzenegger"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        addSubview(actorLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor,constant: -10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            actorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10),
            actorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
