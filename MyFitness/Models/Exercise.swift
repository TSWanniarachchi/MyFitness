//
//  Exercise.swift
//  MyFitness
//
//  Created by Sachin on 5/11/23.
//

import Foundation

// MARK: - Exercise Model
struct Exercise: Codable {
    let id: String
    let name: String
    let group: String
    let category: String
    let equipment: String
    let difficultyLevel: Int
    let targetMuscle: [String]
    let context: ContextField
    let burnedCalories: Int
    let media: MediaField
    let description: String
    let isActive: Bool
    let createdDateTime: Date
}

struct ContextField: Codable {
    let sets: Int
    let reps: Int
    let rest: Int?
    let duration: Int
}

struct MediaField: Codable {
    let image: String
    let video: String?
}
