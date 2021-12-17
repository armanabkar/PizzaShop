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
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    @UseAutoLayout var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
            .font: UIFont.systemFont(ofSize: 28, weight: .medium),
            .foregroundColor: UIColor.black,
        ]))
        button.configuration = .filled()
        button.configuration?.attributedTitle = buttonTitle
        button.tintColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(logOutTapped(_ :)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setUpLabels()
        configureConstraints()
    }
    
    @objc func logOutTapped(_ sender: UIButton) {
        viewModel.removeAndResetUserData(from: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setUpLabels() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(addressLabel)
        view.addSubview(appVersionLabel)
        view.addSubview(logOutButton)
        nameLabel.text = UserDefaultsService.shared.name
        phoneLabel.text = UserDefaultsService.shared.phone
        addressLabel.text = UserDefaultsService.shared.address
        appVersionLabel.text = viewModel.getAppVersion()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 180),
            profileImage.heightAnchor.constraint(equalToConstant: 180),
            profileImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            phoneLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            addressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            addressLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            appVersionLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            appVersionLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 50),
            logOutButton.topAnchor.constraint(equalTo: appVersionLabel.bottomAnchor, constant: 20),
            logOutButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
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
