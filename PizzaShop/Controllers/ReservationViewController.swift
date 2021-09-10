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
    @IBOutlet weak var segmentControlView: UISegmentedControl!
    @IBOutlet weak var requestField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Dear \(UserDefaultsService.shared.name),"
    }
    
    @IBAction func submitReservationTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let index = segmentControlView.selectedSegmentIndex
        if let segmentTitle = segmentControlView.titleForSegment(at: index) {
            let newReservation = Reservation(name: UserDefaultsService.shared.name, phone: UserDefaultsService.shared.phone, tableSize: segmentTitle, time: dateFormatter.string(from: datePicker.date), request: requestField.text)
            WebService.shared.submitReservation(reservation: newReservation, completion: { result in
                switch result {
                    case .success( _):
                        UIAlertController.showAlert(title: K.Alert.orderTitle, message: K.Alert.reservationMessage, from: self)
                    case .failure(let error):
                        UIAlertController.showAlert(message: error.localizedDescription, from: self)
                }
            })
        }
    }
    
}
