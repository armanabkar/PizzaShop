//
//  ProfileViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/27/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let viewModel = ProfileViewModel()
    @UseAutoLayout var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .white
        return image
    }()
    @UseAutoLayout var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        return label
    }()
    @UseAutoLayout var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        return label
    }()
    @UseAutoLayout var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = UIFont.systemFont(ofSize: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    @UseAutoLayout var appVersionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    @UseAutoLayout var logOutButton: UIButton = {
        let button = UIButton()
        let buttonTitle = AttributedString("Log Out", attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 26, weight: .semibold),
            .foregroundColor: UIColor.black,
        ]))
        button.configuration = .filled()
        button.configuration?.attributedTitle = buttonTitle
        button.tintColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        configureViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLabels()
        view.backgroundColor = .black
    }
    
    @objc func logOutTapped(_ sender: UIButton) {
        viewModel.removeAndResetUserData(from: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setUpLabels() {
        nameLabel.text = UserDefaultsService.shared.name
        phoneLabel.text = UserDefaultsService.shared.phone
        addressLabel.text = UserDefaultsService.shared.address
        appVersionLabel.text = viewModel.getAppVersion()
        logOutButton.addTarget(self,
                         action: #selector(logOutTapped(_ :)),
                         for: .touchUpInside)
    }
    
    func configureViews() {
        view.addSubviews([profileImage,
                          nameLabel,
                          phoneLabel,
                          addressLabel,
                          appVersionLabel,
                          logOutButton])
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 180),
            profileImage.heightAnchor.constraint(equalToConstant: 180),
            profileImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 35),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 25),
            nameLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
            phoneLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            addressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
            addressLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            appVersionLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            appVersionLabel.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -25),
            logOutButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -35)
        ])
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ProfileViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileViewController").toPreview()
    }
}
#endif
