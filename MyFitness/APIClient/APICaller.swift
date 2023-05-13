//
//  APICaller.swift
//  MyFitness
//
//  Created by Sachin on 5/11/23.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    enum APIError: Error{
        case failedToCreateRequest
        case failedToGetData
    }
    
    // MARK: - Exercises
    public func getExercises(URL url: String, completion: @escaping (Result<[ExerciseModel], Error>) -> Void) {
        
        createRequest(with: URL(string: url), type: .GET) {
            request in
            
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                
                guard let data = data, error == nil else{
                    completion(.failure(error ?? APIError.failedToGetData))
                    return
                }
                
                // Decode response
                do{
                    let result = try JSONDecoder().decode([ExerciseModel].self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    
    
    // MARK: - Create HTTP Request
    enum HTTPMethod: String{
        case GET
        case POST
        case DELETE
    }
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               body: [String: AnyHashable]? = nil,
                               completion: @escaping (URLRequest) -> Void) {
        
        guard let apiURL = url else {
            return
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 60
        
        if (type == .POST){
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: body!, options: .fragmentsAllowed)
        }
        
        completion(request)
    }
    
}
