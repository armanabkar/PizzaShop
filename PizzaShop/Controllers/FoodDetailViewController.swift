//
//  FoodDetailViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    var food: Food?
    var cartTabItem: UITabBarItem?
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodIngredientsLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIElements()
    }
    
    @IBAction func addToCartTapped(_ sender: UIButton) {
        addToCart()
        UITabBarController.updateCartTabBadge(tabItem: cartTabItem!, from: self)
    }
    
    func addToCart() {
        guard let foodName = food?.name,
              let foodPrice = food?.price else { return }
        
        CoreDataService.shared.addToCart(foodName: foodName, foodPrice: "\(foodPrice)") { result in
            switch result {
                case .success(_):
                    UIAlertController.showAlert(title: K.Alert.cartTitle, message: "\(foodName) added to the cart.", from: self)
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                case .failure(let error):
                    UIAlertController.showAlert(message: "Error saving cart: \(error.localizedDescription)",
                                                from: self)
            }
        }
    }
    
    func configureUIElements() {
        guard let foodName = food?.name,
              let foodPrice = food?.price,
              let foodImage = food?.image else { return }
        
        self.foodNameLabel.text = foodName
        self.foodPriceLabel.text = "\(foodPrice)$"
        ImageLoader.sharedInstance.imageForUrl(urlString: foodImage) { [weak self] (image, url) in
            if let image = image {
                self?.foodImageView.image = image
            }
        }
        
        self.foodIngredientsLabel.text = food?.ingredients
        if food?.ingredients == nil {
            self.foodIngredientsLabel.isHidden = true
        }
    }
    
}
