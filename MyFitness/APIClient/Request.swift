//
//  Request.swift
//  MyFitness
//
//  Created by Sachin on 5/11/23.
//

import Foundation

/// Object that represents a  single API call
final class Request{
    
    private struct Constants{
        static let baseUrl = "https://myfitness-back-end.onrender.com/api"
    }
    
    private let endpoint: Endpoint
    //private let pathComponents: Set<String>
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]
    
    /// Construct request
    /// - Parameters:
    /// - endpoint: Target endpoint
    /// - pathComponents: Collection of path components
    /// - queryParameters: Collection of query parameter
    public init(endpoint: Endpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = [])
    {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    /// Constructed url for the api request in string format
    private var urlString: String{
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty{
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty{
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    public var url : String{
        return urlString
    }
    
}
