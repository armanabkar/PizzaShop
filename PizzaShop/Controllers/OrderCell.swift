//
//  OrderCell.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/27/21.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
