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
    /// Endpoint to get foods info
    case foods
    /// Endpoint to get favorites info
    case favorites
}
