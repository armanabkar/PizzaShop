//
//  MenuViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.foodCellIdentifier, for: indexPath) as! MenuCell
        cell.foodNameLabel.text = items[indexPath.row].name
        cell.foodPriceLabel.text = String(items[indexPath.row].price)
        cell.foodImageView.image = UIImage()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.detailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FoodDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.foodNameLabel.text = items[indexPath.row].name
            destinationVC.foodPriceLabel.text = String(items[indexPath.row].price)
            destinationVC.foodIngredientsLabel.text = items[indexPath.row].ingredients
            destinationVC.foodImageView.image = UIImage()
        }
    }
    
}
