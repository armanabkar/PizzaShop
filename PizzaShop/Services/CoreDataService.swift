//
//  CoreDataService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit
import CoreData

class CoreDataService {
    
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func resetAllRecords(in entity : String, from controller: UIViewController) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            UIAlertController.showAlert(message: error.localizedDescription, from: controller)
        }
    }

}
