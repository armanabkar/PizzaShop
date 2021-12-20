//
//  CoreDataService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit
import CoreData

typealias getCartItemsClosure = (Result<[Cart], CoreDataError>) -> Void
typealias CoreDataCRUDClosure = (Result<String, CoreDataError>) -> Void

enum CoreDataError: Error {
    case savingError
    case loadingError
    case custom(String?)
}

final class CoreDataService {
    
    static let shared = CoreDataService()
    private init() {}
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    /// Add the item to the cart
    func addToCart(foodName: String, foodPrice: String, completion: @escaping CoreDataCRUDClosure) {
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
    
    /// Save the cart items
    func saveCartItems(completion: @escaping CoreDataCRUDClosure) {
        do {
            try context.save()
            completion(.success("Saved successfully"))
        } catch {
            completion(.failure(.savingError))
        }
    }
    
    /// Fetch the cart items from Core Data
    func loadCartItems(completion: @escaping getCartItemsClosure) {
        let request : NSFetchRequest<Cart> = Cart.fetchRequest()
        
        do{
            let cartItems = try context.fetch(request)
            completion(.success(cartItems))
        } catch {
            completion(.failure(.loadingError))
        }
    }
    
    /// Delete an item from Core Data
    func deleteCartItem(item: Cart) {
        context.delete(item)
    }

    /// Remove all items from Core Data
    func resetAllRecords(in entity : String, completion: @escaping CoreDataCRUDClosure) {
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
    
}
