//
//  CartViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var cartItems: [Cart] = []
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
    }
    
    @IBAction func submitOrderTapped(_ sender: Any) {
        if !cartItems.isEmpty {
            var orderNames: [String] = []
            cartItems.forEach { item in
                if let name = item.name {
                    orderNames.append(name)
                }
            }
            let newOrder: Order = Order(name: UserDefaultsService.shared.name, phone: UserDefaultsService.shared.phone, address: UserDefaultsService.shared.address, items: orderNames, totalPrice: totalPrice)
            DispatchQueue.main.async {
                WebService.shared.submitOrder(order: newOrder, completion: { result in
                    switch result {
                        case .success( _):
                            CoreDataService.shared.resetAllRecords(in: K.coreDataEntityName) { result in
                                switch result {
                                    case .success(_):
                                        self.cartItems.removeAll()
                                        self.tableView.reloadData()
                                        self.navigationBar.topItem?.title = "Total: 0$"
                                        UIAlertController.showAlert(title: K.alert.orderTitle, message: K.alert.orderMessage, from: self)
                                        NotificationCenter.createNotification(title: "Dear \(UserDefaultsService.shared.name)", body: "Your order has been delivered. Thank you for choosing us.", date: Date().addingTimeInterval(10), from: self)
                                    case .failure(let error):
                                        UIAlertController.showAlert(message: error.localizedDescription, from: self)
                                }
                            }
                        case .failure(let error):
                            UIAlertController.showAlert(message: error.localizedDescription, from: self)
                    }
                })
            }
        } else {
            UIAlertController.showAlert(message: K.alert.emptyCart, from: self)
        }
    }
    
    func saveCartItems() {
        CoreDataService.shared.saveCartItems { result in
            switch result {
                case .success(_):
                    self.tableView.reloadData()
                case .failure(let error):
                    UIAlertController.showAlert(message: "Error saving to the cart: \(error.localizedDescription)",
                                                from: self)
            }
        }
    }
    
    func loadCartItems() {
        cartItems = []
        CoreDataService.shared.loadCartItems { result in
            switch result {
                case .success(let cartItems):
                    self.cartItems.append(contentsOf: cartItems)
                    self.tableView.reloadData()
                case .failure(let error):
                    UIAlertController.showAlert(message: "Error loading cart: \(error.localizedDescription)",
                                                from: self)
            }
        }
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
            CoreDataService.shared.deleteCartItem(item: commit)
            cartItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            navigationBar.topItem?.title = "Total: \(totalPrice)$"
            self.saveCartItems()
        }
    }
    
}
