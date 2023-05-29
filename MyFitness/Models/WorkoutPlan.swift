//
//  WorkoutPlan.swift
//  MyFitness
//
//  Created by Sachin on 5/11/23.
//

import Foundation

// MARK: - WorkoutPlan Model
struct WorkoutPlanModel: Codable {
    let id: String
    let name: String
    let group: String
    let equipment: String
    let context: ContextField
    let media: MediaField
}
