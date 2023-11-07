//
//  DetailViewController.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 6.11.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movieDetail: MovieDetail?
    var selectedMovieId: String?
    var actorsArray: [String] = []
    
    let backButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        return button
    }()
    
    let actorCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let movieImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let directorLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let introductionText: UILabel = {
       let label = UILabel()
        label.text = "Introduction"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.text = "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father, the ambitious celestial being Ego."
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    let actorsText: UILabel = {
       let label = UILabel()
        label.text = "Actors"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var rating: StarRatingView!
    
    let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
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
        if let id = selectedMovieId {
            viewModel.fetchDetail(with: id)
        }
    }
    
    private func setupUI() {
        let screenHeight = UIScreen.main.bounds.height
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0.7
        
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        rating = StarRatingView(frame: CGRect(x: 0, y: 0, width: 50, height: 20), rating: 10)
        rating.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundImageView)
        view.addSubview(blurView)
        view.addSubview(contentView)
        view.sendSubviewToBack(backgroundImageView)
        view.addSubview(backButton)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieLabel)
        contentView.addSubview(rating)
        contentView.addSubview(directorLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(introductionText)
        contentView.addSubview(infoLabel)
        contentView.addSubview(actorsText)
        contentView.addSubview(actorCollectionView)
        
        backButton.addTarget(self, action: #selector(toPreviousPage), for: .touchUpInside)
        
        actorCollectionView.register(ActorsCollectionViewCell.self, forCellWithReuseIdentifier: ActorsCollectionViewCell.identifier)
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: screenHeight * 0.7),
            
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -60),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -200),
            movieImageView.heightAnchor.constraint(equalToConstant: screenHeight * 0.30),
            
            movieLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            movieLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            movieLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            rating.topAnchor.constraint(equalTo: movieLabel.bottomAnchor, constant: 10),
            rating.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            directorLabel.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 30),
            directorLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            directorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 15),
            releaseDateLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            introductionText.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20),
            introductionText.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: introductionText.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            actorsText.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 30),
            actorsText.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            
            actorCollectionView.topAnchor.constraint(equalTo: actorsText.bottomAnchor, constant: 10),
            actorCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actorCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actorCollectionView.heightAnchor.constraint(equalToConstant: screenHeight * 0.25)
        ])

    }
    
    
    
}
