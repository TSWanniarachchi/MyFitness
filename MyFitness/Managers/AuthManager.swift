//
//  File.swift
//  MyFitness
//
//  Created by Sachin on 5/18/23.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    static var isSignIn = false
    static var username = "sachin"
    static var fullName = "Michael Bernardo"
    static var gender = ""
    static var height = "0.00"
    static var weight = "0.00"
    static var fitnessGoal = ""
    static var difficultyLevel = 0
}
