//
//  Networker.swift
//  ApiParseTest
//
//  Created by David Kao on 2021-03-08.
//

import Foundation

struct ApiFoodTruck: Codable {
    var metadata: String
    var vendor: [FoodTruck]
}

enum NetworkerError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}


class Networker {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func getFoodTruck(completion: @escaping ([FoodTruck]?, Error?) -> Void) {
        
        
        let searchURL = "http://data.streetfoodapp.com/1.1/schedule/vancouver/"
        guard let url = URL(string: searchURL) else {
            print("error guard")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    print("1 error")
                    completion(nil, error)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    print("2 error")
                    completion(nil, NetworkerError.badResponse)
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    print("3 error")
                    completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print("4 error")
                    completion(nil, NetworkerError.badData)
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ApiFoodTruck.self, from: data)
                print("in do")
                DispatchQueue.main.async {
                    print("5 error")
                    completion(result.vendor, nil)
                }
                
                
            } catch let error {
                DispatchQueue.main.async {
                   // print(error)
                    completion(nil, error)
                }
            }
            
        }
        task.resume()
    }
}

