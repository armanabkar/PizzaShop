//
//  FoodDetailViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
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
    }
    
}
