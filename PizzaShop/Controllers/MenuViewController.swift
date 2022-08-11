//
//  MenuViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit
import Combine

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: K.Identifiers.MenuCellNibName, bundle: nil),
                           forCellReuseIdentifier: K.Identifiers.menuCellIdentifier)
        viewModel.getFoods(from: self) {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.menuCellIdentifier, for: indexPath) as! MenuCell
        if let food = viewModel.items[indexPath.row] {
            cell.foodNameLabel.text = food.name
            cell.foodPriceLabel.text = String(food.price)
            ImageLoader.sharedInstance.imageForUrl(urlString: "\(K.URL.baseUrl)/\(food.image)") { (image, url) in
                if image != nil {
                    cell.foodImageView.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Identifiers.detailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FoodDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            if let item = viewModel.items[indexPath.row] {
                let food = Food(name: item.name, type: nil, price: item.price, ingredients: item.ingredients, image: "\(K.URL.baseUrl)/\(item.image)")
                destinationVC.food = food
                destinationVC.cartTabItem = tabBarController?.tabBar.items?[2]
            }
        }
    }
    
}
