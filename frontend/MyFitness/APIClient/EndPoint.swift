//
//  EndPoint.swift
//  EatSure
//
//  Created by Sachin on 5/8/23.
//

import Foundation

/// Represents unique API endpoints
@frozen enum Endpoint: String {
    /// Endpoint to get exercise info
    case exercises
    /// Endpoint to get custom-schedules info
    case customSchedules = "custom-schedules"
    /// Endpoint to get users info
    case users
}
