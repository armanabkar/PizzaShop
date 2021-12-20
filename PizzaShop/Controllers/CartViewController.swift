//
//  CartViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var webService: API = WebService.shared
    var cartItems: [Cart] = []
    var totalPrice: Float {
        round(cartItems.reduce(0) { $0 + $1.price } * 1000) / 1000
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
        submitOrder()
    }
    
    func submitOrder() {
        guard !cartItems.isEmpty else {
            UIAlertController.showAlert(message: K.Alert.emptyCart, from: self)
            return
        }
        
        var orderNames: [String] {
            var names: [String] = []
            cartItems.forEach { item in
                if let name = item.name {
                    names.append(name)
                }
            }
            return names
        }
        let newOrder: Order = Order(name: UserDefaultsService.shared.name,
                                    phone: UserDefaultsService.shared.phone,
                                    address: UserDefaultsService.shared.address,
                                    items: orderNames,
                                    totalPrice: totalPrice)
        Task.init {
            do {
                let responseCode = try await webService.submitOrder(order: newOrder)
                if responseCode == 200 {
                    CoreDataService.shared.resetAllRecords(in: K.CoreData.entityName) { result in
                        switch result {
                            case .success(_):
                                self.cartItems.removeAll()
                                self.tableView.reloadData()
                                self.navigationBar.topItem?.title = "Total: 0$"
                                UIAlertController.showAlert(title: K.Alert.orderTitle,
                                                            message: K.Alert.orderMessage,
                                                            from: self)
                            case .failure(let error):
                                UIAlertController.showAlert(message: error.localizedDescription,
                                                            from: self)
                        }
                    }
                }
            } catch let error {
                UIAlertController.showAlert(message: error.localizedDescription,
                                            from: self)
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.orderCellIdentifier, for: indexPath) as! OrderCell
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
