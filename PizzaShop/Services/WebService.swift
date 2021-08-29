//
//  WebService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/28/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
    case custom(String?)
}

class WebService {
    
    func getAllFoods(completion: @escaping (Result<[Food]?, NetworkError>) -> Void) {
        guard let url = URL(string: K.URL.foodUrl) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let foods = try? JSONDecoder().decode([Food].self, from: data)
            
            DispatchQueue.main.async {
                completion(.success(foods))
            }
        }
        .resume()
    }
    
    func submitOrder(order: Order, completion: @escaping (Result<Int?, NetworkError>) -> Void) {
        guard let url = URL(string: K.URL.newOrderUrl) else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        do {
            let orderJsonData = try encoder.encode(order)
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            request.httpBody = orderJsonData
            request.timeoutInterval = 20
        } catch {
            completion(.failure(.decodingError))
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            if let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    completion(.success(response.statusCode))
                }
            }
        }
        .resume()
    }
}
