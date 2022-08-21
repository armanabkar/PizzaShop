//
//  ReservationViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/5/21.
//

import UIKit

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentControlView: UISegmentedControl!
    @IBOutlet weak var requestField: UITextField!
    
    var webService: API = WebService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitReservationTapped(_ sender: Any) {
        submitReservation()
    }
    
    func submitReservation() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let index = segmentControlView.selectedSegmentIndex
        guard let segmentTitle = segmentControlView.titleForSegment(at: index) else { return }
        let newReservation = Reservation(name: UserDefaultsService.shared.name,
                                         phone: UserDefaultsService.shared.phone,
                                         tableSize: segmentTitle,
                                         time: dateFormatter.string(from: datePicker.date),
                                         request: requestField.text)
        sendReservationRequest(reservation: newReservation)
    }
    
    private func sendReservationRequest(reservation: Reservation) {
        Task.init {
            do {
                let responseCode = try await webService.submitReservation(reservation: reservation)
                if responseCode == 200 {
                    UIAlertController.showAlert(title: K.Alert.orderTitle,
                                                message: K.Alert.reservationMessage,
                                                from: self)
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }
            } catch let error {
                UIAlertController.showAlert(message: error.localizedDescription,
                                            from: self)
            }
        }
    }
    
}
