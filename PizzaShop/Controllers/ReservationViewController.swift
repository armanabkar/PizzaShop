//
//  ReservationViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/5/21.
//

import UIKit

class ReservationViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sizeField: UITextField!
    @IBOutlet weak var requestField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Dear \(UserDefaultsService.shared.name),"
    }

    @IBAction func submitReservationTapped(_ sender: Any) {
    }

}
