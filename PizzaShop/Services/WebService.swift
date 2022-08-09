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
    func login(user: User) async throws -> User
    func register(user: User) async throws -> User
}

@available(iOS 13, *)
final class WebService: API {
    
    private init() {}
    static let shared = WebService()
    private let foodsCacheKey = "foods"
    private let postMethod = "POST"
    private let contentType = "Application/json"
    private let HTTPHeaderField = "Content-Type"
    private var foodsCache = NSCache<AnyObject, AnyObject>()
    
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
        if let foods = self.foodsCache.object(forKey: foodsCacheKey as AnyObject) as? [Food] {
            return foods
        }
        
        guard let url = URL(string: K.URL.foodUrl) else { throw NetworkError.badURL }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.noData }
        let decodedFoods = try JSONDecoder().decode([Food].self, from: data)
        self.foodsCache.setObject(decodedFoods as AnyObject, forKey: foodsCacheKey as AnyObject)
        
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
    func login(user: User) async throws -> User {
        guard let url = URL(string: K.URL.login) else { throw NetworkError.badURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = postMethod
        request.setValue(contentType, forHTTPHeaderField: HTTPHeaderField)
        let encoder = JSONEncoder()
        do {
            let phoneJsonData = try encoder.encode(user)
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            request.httpBody = phoneJsonData
            request.timeoutInterval = 20
        } catch {
            throw NetworkError.decodingError
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.custom(K.Alert.userDoesNotExist) }
        let decodedUser = try JSONDecoder().decode(User.self, from: data)
        return decodedUser
    }
    
    /// Send register request with a name, phone, and address to the server
    func register(user: User) async throws -> User {
        guard let url = URL(string: K.URL.register) else { throw NetworkError.badURL }
        
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
            throw NetworkError.decodingError
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.custom(K.Alert.userAlreadyExists) }
        let decodedUser = try JSONDecoder().decode(User.self, from: data)
        return decodedUser
    }
    
}
