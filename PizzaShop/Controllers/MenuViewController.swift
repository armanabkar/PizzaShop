//
//  MenuViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var webService: API = WebService.shared // Property Injection - Can be replaced with stub in testing
    var items: [Food?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAllFoods()
    }
    
    func getAllFoods() {
        webService.getAllFoods { [weak self] result in
            switch result {
                case .success(let fetchedFoods):
                    if let fetchedFoods = fetchedFoods {
                        self?.items.append(contentsOf: fetchedFoods)
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    UIAlertController.showAlert(message: error.localizedDescription, from: self!)
            }
        }
        
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.foodCellIdentifier, for: indexPath) as! MenuCell
        if let food = self.items[indexPath.row] {
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
        performSegue(withIdentifier: K.detailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FoodDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            
            if let item = items[indexPath.row] {
                let food = Food(name: item.name, type: nil, price: item.price, ingredients: item.ingredients, image: "\(K.URL.baseUrl)/\(item.image)")
                destinationVC.food = food
            }
        }
    }
    
}
