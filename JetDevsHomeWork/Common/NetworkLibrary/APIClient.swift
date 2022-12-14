//
//  APIClient.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation

class APIClient {
    
    private let BASEURL = "https://jetdevs.mocklab.io/"
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()
    
    /// This function will
    /// - Parameters:
    ///   - withParams: parameters to pass wth api call
    ///   - onService: service url endpoint to interact
    ///   - handler: response handler
    func POSTData(withParams: [String: Any], onService: String, handler: @escaping ((Result<Data?, APIError>) -> Void)) {
        
        guard let apiUrl = URL(string: BASEURL + onService) else {
            handler(.failure(.error("Calling an invalid service")))
            return
        }
        
        var urlRequest = URLRequest(url: apiUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: withParams, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
        } catch {
            handler(.failure(.error(error.localizedDescription)))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
            
            if let error = error {
                handler(.failure(.error(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                handler(.failure(.error(ErrorMessages.nullResponse)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    handler(.failure(.error(ErrorMessages.incorrectResponseFormat)))
                    return
                }
               
                handler(.success(data))
               
            } else {
                handler(.failure(.error(ErrorMessages.serverError)))
            }
        }
        
        task.resume()
    }
    
}
