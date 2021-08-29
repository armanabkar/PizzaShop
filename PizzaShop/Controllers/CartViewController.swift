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
    var totalPrice: Float {
        cartItems.reduce(0) { $0 + $1.price }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadCartItems()
        navigationBar.topItem?.title = String(format: "Total: %.2f$", totalPrice)
    }
    
    @IBAction func submitOrderTapped(_ sender: Any) {
        let request : NSFetchRequest<Cart> = Cart.fetchRequest()
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object)
            }
        }
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        guard let phone = UserDefaults.standard.string(forKey: "phone") else { return }
        guard let address = UserDefaults.standard.string(forKey: "address") else { return }
        WebService().submitOrder(order: Order(name: name, phone: phone, address: address, items: [""], totalPrice: totalPrice), completion: { result in
            switch result {
                case .success(let responseCode):
                    if let responseCode = responseCode, responseCode == 200 {
                        DispatchQueue.main.async {
                            self.cartItems.removeAll()
                            self.tableView.reloadData()
                            self.navigationBar.topItem?.title = "Total: 0$"
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    func loadCartItems() {
        let request : NSFetchRequest<Cart> = Cart.fetchRequest()
        
        do{
            cartItems = try context.fetch(request)
        } catch {
            print("Error loading notes \(error)")
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
    
}
