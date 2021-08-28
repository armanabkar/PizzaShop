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
    
    var cartItems: [Food] = []
    var totalPrice: String {
        String(cartItems.reduce(0) { $0 + $1.price })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        navigationBar.topItem?.title = "Total: \(totalPrice)$"
    }
    
    @IBAction func submitOrderTapped(_ sender: Any) {
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
