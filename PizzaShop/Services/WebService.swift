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

protocol API {
    func start() async throws -> Int
    func getAllFoods() async throws -> [Food]
    func submitOrder(order: Order) async throws -> Int
    func submitReservation(reservation: Reservation) async throws -> Int
    func login(phone: User, completion: @escaping getUserClosure)
    func register(user: User, completion: @escaping getUserClosure)
}

typealias getUserClosure = (Result<User?, NetworkError>) -> Void

final class WebService: API {
    
    private init() {}
    static let shared = WebService()
    private let postMethod = "POST"
    private let contentType = "Application/json"
    private let HTTPHeaderField = "Content-Type"
    
    /// Start the remote server because it shut downs
    func start() async throws -> Int {
        guard let url = URL(string: K.URL.startUrl) else { throw NetworkError.badURL }
        let urlRequest = URLRequest(url: url)
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.noData }
        return response.statusCode
    }
    
    /// Fetch all foods from the server
    func getAllFoods() async throws -> [Food] {
        guard let url = URL(string: K.URL.foodUrl) else { throw NetworkError.badURL }
        
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.noData }
        let decodedFoods = try JSONDecoder().decode([Food].self, from: data)
        
        return decodedFoods
    }
    
    /// Send the order to the server
    func submitOrder(order: Order) async throws -> Int {
        guard let url = URL(string: K.URL.newOrderUrl) else { throw NetworkError.badURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = postMethod
        request.setValue(contentType, forHTTPHeaderField: HTTPHeaderField)
        let encoder = JSONEncoder()
        do {
            let orderJsonData = try encoder.encode(order)
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            request.httpBody = orderJsonData
            request.timeoutInterval = 20
        } catch {
            throw NetworkError.decodingError
        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.noData }
        return response.statusCode
    }
    
    /// Send the reservation to the server
    func submitReservation(reservation: Reservation) async throws -> Int {
        guard let url = URL(string: K.URL.newReservationUrl) else { throw NetworkError.badURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = postMethod
        request.setValue(contentType, forHTTPHeaderField: HTTPHeaderField)
        let encoder = JSONEncoder()
        do {
            let orderJsonData = try encoder.encode(reservation)
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            request.httpBody = orderJsonData
            request.timeoutInterval = 20
        } catch {
            throw NetworkError.decodingError
        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.noData }
        return response.statusCode
    }
    
    /// Send login request with the phone number to the server
    func login(phone: User, completion: @escaping getUserClosure) {
        guard let url = URL(string: K.URL.login) else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = postMethod
        request.setValue(contentType, forHTTPHeaderField: HTTPHeaderField)
        let encoder = JSONEncoder()
        do {
            let phoneJsonData = try encoder.encode(phone)
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            request.httpBody = phoneJsonData
            request.timeoutInterval = 20
        } catch {
            completion(.failure(.decodingError))
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let user = try? JSONDecoder().decode(User.self, from: data)
            
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completion(.success(user))
                } else {
                    completion(.failure(.custom(K.Alert.userDoesNotExist)))
                }
            }
        }
        .resume()
    }
    
    /// Send register request with a name, phone, and address to the server
    func register(user: User, completion: @escaping getUserClosure) {
        guard let url = URL(string: K.URL.register) else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = postMethod
        request.setValue(contentType, forHTTPHeaderField: HTTPHeaderField)
        let encoder = JSONEncoder()
        do {
            let userJsonData = try encoder.encode(user)
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            request.httpBody = userJsonData
            request.timeoutInterval = 20
        } catch {
            completion(.failure(.decodingError))
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let user = try? JSONDecoder().decode(User.self, from: data)
            
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completion(.success(user))
                } else {
                    completion(.failure(.custom(K.Alert.userAlreadyExists)))
                }
            }
        }
        .resume()
    }
    
}
