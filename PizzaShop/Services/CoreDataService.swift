//
//  CoreDataService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit
import CoreData

enum CoreDataError: Error {
    case savingError
    case loadingError
    case custom(String?)
}

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func resetAllRecords(in entity : String, completion: @escaping (Result<String, CoreDataError>) -> Void) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
            completion(.success("All records deleted"))
        } catch {
            completion(.failure(.savingError))
        }
    }
    
    func addToCart(foodName: String, foodPrice: String, completion: @escaping (Result<String, CoreDataError>) -> Void) {
        let newCart = Cart(context: self.context)
        newCart.name = foodName
        newCart.price = Float(foodPrice) ?? 0
        do {
            try context.save()
            completion(.success("Saved To Cart"))
        } catch {
            completion(.failure(.savingError))
        }
    }
    
    func saveCartItems(completion: @escaping (Result<String, CoreDataError>) -> Void) {
        do {
            try context.save()
            completion(.success("Saved successfully"))
        } catch {
            completion(.failure(.savingError))
        }
    }
    
    func loadCartItems(completion: @escaping (Result<[Cart], CoreDataError>) -> Void) {
        let request : NSFetchRequest<Cart> = Cart.fetchRequest()
        
        do{
            let cartItems = try context.fetch(request)
            completion(.success(cartItems))
        } catch {
            completion(.failure(.loadingError))
        }
    }
    
    func deleteCartItem(item: Cart) {
        context.delete(item)
    }

}
