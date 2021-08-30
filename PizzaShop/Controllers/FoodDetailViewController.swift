//
//  FoodDetailViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var foodImage = ""
    var foodName = ""
    var foodIngredients: String?
    var foodPrice = ""
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodIngredientsLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.foodNameLabel.text = self.foodName
            self.foodIngredientsLabel.text = self.foodIngredients
            self.foodPriceLabel.text = "\(self.foodPrice)$"
            ImageLoader.sharedInstance.imageForUrl(urlString: self.foodImage) { (image, url) in
                if image != nil {
                    self.foodImageView.image = image
                }
            }
            if self.foodIngredients == nil {
                self.foodIngredientsLabel.isHidden = true
            }
        }
        
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        DispatchQueue.main.async {
            let newCart = Cart(context: self.context)
            newCart.name = self.foodName
            newCart.price = Float(self.foodPrice) ?? 0
            do {
                try self.context.save()
                UIAlertController.showAlert(title: "Cart", message: "\(self.foodName) added to the cart.", from: self)
            } catch {
                UIAlertController.showAlert(message: "Error saving cart: \(error.localizedDescription)",
                                            from: self)
            }
        }

    }
    
}
