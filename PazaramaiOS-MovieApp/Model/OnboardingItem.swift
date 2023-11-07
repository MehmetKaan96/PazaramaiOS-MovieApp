//
//  OnboardingItem.swift
//  PazaramaiOS-MovieApp
//
//  Created by Mehmet Kaan on 6.11.2023.
//

import Foundation
import UIKit

struct OnboardingItem {
    let title: String
    let description: String
    let image: UIImage
}

let onboardingData = [
    OnboardingItem(title: "Welcome!", description: "Join us to discover your favorite movies and elevate your cinema experience.", image: UIImage(named: "backgroundImage1")!),
    OnboardingItem(title: "Thousands of Movie Choices", description: "Dive into the fascinating world of cinema with in-depth movie information and insights.", image: UIImage(named: "backgroundImage2")!),
    OnboardingItem(title: "Get Started", description: "Let's get started and enjoy the app.", image: UIImage(named: "backgroundImage3")!)
]
