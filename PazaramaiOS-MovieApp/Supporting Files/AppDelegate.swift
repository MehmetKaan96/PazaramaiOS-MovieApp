//
//  AppDelegate.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow()
//        
//        window?.rootViewController = OnboardingViewController()
//        window?.makeKeyAndVisible()
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
            
            if !hasSeenOnboarding {
                showOnboarding()
            } else {
                showMainScreen()
            }
        return true
    }
    
    func showOnboarding() {
        window = UIWindow()
        let onboardingViewController = OnboardingViewController()
        window?.rootViewController = onboardingViewController
        window?.makeKeyAndVisible()
    }

    func showMainScreen() {
        window = UIWindow()
        let service: MovieService = APIManager()
        let viewModel = MoviesViewModel(movieService: service)
        let mainViewController = MainViewController(viewModel: viewModel)
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
    
    
}
