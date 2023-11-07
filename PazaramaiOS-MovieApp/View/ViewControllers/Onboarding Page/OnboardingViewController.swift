//
//  OnboardingViewController.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 6.11.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let onboardingImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingData.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .pageControl
        pageControl.direction = .leftToRight
        return pageControl
    }()
    
    let nextButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        return button
    }()
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(onboardingImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
        
            onboardingImageView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 45),
            
            nextButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 150),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
            
            pageControl.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20),
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
        
        ])
        
        setPage(index: 0)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if currentPage == onboardingData.count - 1 {
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            let service: MovieService = APIManager()
            let viewModel = MoviesViewModel(movieService: service)
            let vc = MainViewController(viewModel: viewModel)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } else {
            let nextIndex = min(currentPage + 1, onboardingData.count - 1)
            setPage(index: nextIndex)
        }
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        setPage(index: sender.currentPage)
    }
    
    private func setPage(index: Int) {
        guard index >= 0 && index < onboardingData.count else {
            return
        }
        
        let item = onboardingData[index]
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        onboardingImageView.image = item.image
        pageControl.currentPage = index
        currentPage = index
        
        if index == onboardingData.count - 1 {
            nextButton.setTitle("Get Started", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
}
