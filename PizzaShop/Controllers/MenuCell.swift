//
//  MenuCell.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/27/21.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodImageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
