//
//  CoreDataService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func resetAllRecords(in entity : String, from controller: UIViewController) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try CoreDataService.shared.context.execute(deleteRequest)
            try CoreDataService.shared.context.save()
        } catch {
            UIAlertController.showAlert(message: error.localizedDescription, from: controller)
        }
    }

}
