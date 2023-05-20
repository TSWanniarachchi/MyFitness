//
//  Response.swift
//  MyFitness
//
//  Created by Sachin on 5/16/23.
//

import Foundation

// MARK: - Response Model
struct ResponseModel: Codable {
    let success: Bool
    let message: String
    let data: String
}
