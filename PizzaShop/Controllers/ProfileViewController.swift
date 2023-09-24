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
        image.image = SFSymbols.avatar
        image.tintColor = .black
        return image
    }()
    @UseAutoLayout var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    @UseAutoLayout var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    @UseAutoLayout var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    @UseAutoLayout var appVersionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    @UseAutoLayout var logOutButton: UIButton = {
        let button = UIButton()
        let buttonTitle = AttributedString("Log Out", attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.white,
        ]))
        button.configuration = .filled()
        button.configuration?.attributedTitle = buttonTitle
        button.tintColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    @UseAutoLayout var stackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 15.0
        return stackView
    }()
    @UseAutoLayout var stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 15.0
        return stackView
    }()
    
    override func loadView() {
        super.loadView()
        
        configureViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLabels()
        view.backgroundColor = .white
    }
    
    @objc func logOutTapped(_ sender: UIButton) {
        UIAlertController.confirmationAlert(from: self) { [weak self] _ in
            self?.viewModel.removeAndResetUserData(from: self!)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func setUpLabels() {
//        nameLabel.text = UserDefaultsService.shared.name
//        phoneLabel.text = UserDefaultsService.shared.phone
//        addressLabel.text = UserDefaultsService.shared.address
        nameLabel.text = "Arman Abkar"
        phoneLabel.text = "09363868196"
        addressLabel.text = "Somewhere in the earth, 310202"
        appVersionLabel.text = viewModel.getAppVersion()
        logOutButton.addTarget(self,
                               action: #selector(logOutTapped(_ :)),
                               for: .touchUpInside)
    }
    
    func configureViews() {
        stackView1.addArrangedSubview(profileImage)
        stackView1.addArrangedSubview(nameLabel)
        stackView1.addArrangedSubview(phoneLabel)
        stackView1.addArrangedSubview(addressLabel)
        stackView2.addArrangedSubview(appVersionLabel)
        stackView2.addArrangedSubview(logOutButton)
        view.addSubviews([stackView1,
                          stackView2])
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            stackView1.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            stackView1.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            stackView1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 30),
            stackView1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30),
            stackView2.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            stackView2.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -35),
            stackView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
}

#Preview {
    let view = ProfileViewController()
    return view
}
