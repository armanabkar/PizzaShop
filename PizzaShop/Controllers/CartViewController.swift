//
//  CartViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var cartItems: [Cart] = []
    var orderNames: [String] = []
    var totalPrice: Float {
        Float(String(format: "%.2f" ,cartItems.reduce(0) { $0 + $1.price })) ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadCartItems()
        navigationBar.topItem?.title = "Total: \(totalPrice)$"
        
        for item in cartItems {
            if let name = item.name {
                orderNames.append(name)
            }
        }
    }
    
    @IBAction func submitOrderTapped(_ sender: Any) {
        WebService().submitOrder(order: Order(name: UserDefaultsService.name,
                                              phone: UserDefaultsService.phone,
                                              address: UserDefaultsService.address,
                                              items: orderNames,
                                              totalPrice: totalPrice), completion: { result in
            switch result {
                case .success( _):
                    DispatchQueue.main.async {
                        CoreDataService.resetAllRecords(in: "Cart", from:self)
                        self.cartItems.removeAll()
                        self.tableView.reloadData()
                        self.navigationBar.topItem?.title = "Total: 0$"
                        UIAlertController.showAlert(title: "Thank You", message: "Your order has been received. We will deliver it to you as soon as possible.", from: self)

                    }
                case .failure(let error):
                    UIAlertController.showAlert(message: error.localizedDescription, from: self)
            }
        })
    }
    
    func saveCartItems() {
        do {
            try context.save()
        } catch {
            UIAlertController.showAlert(message: "Error saving cart: \(error.localizedDescription)",
                                        from: self)
        }
        
        tableView.reloadData()
    }
    
    func loadCartItems() {
        let request : NSFetchRequest<Cart> = Cart.fetchRequest()
        
        do{
            cartItems = try context.fetch(request)
        } catch {
            UIAlertController.showAlert(message: "Error loading cart: \(error.localizedDescription)",
                                        from: self)
        }
        
        tableView.reloadData()
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.orderCellIdentifier, for: indexPath) as! OrderCell
        cell.orderNameLabel.text = cartItems[indexPath.row].name
        cell.orderPriceLabel.text = "\(String(cartItems[indexPath.row].price))$"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = cartItems[indexPath.row]
            context.delete(commit)
            cartItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            navigationBar.topItem?.title = "Total: \(totalPrice)$"
            self.saveCartItems()
        }
    }
    
}
