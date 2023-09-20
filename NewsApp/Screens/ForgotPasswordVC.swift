//
//  ForgotPasswordVC.swift
//  NewsApp
//
//  Created by Seher Köse on 15.09.2023.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Forgot Password?", subTitle: "Reset your password..")
    private let emailField = AuthTextField(fieldType: .email)
    private let resetPasswordButton = AuthButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.resetPasswordButton.addTarget(self, action: #selector(didTappedForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    private func setUpUI(){
        self.view.backgroundColor = UIColor(hex: "F8F0E5")
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(resetPasswordButton)
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 230),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.resetPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            self.resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc private func didTappedForgotPassword(){
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email){
            presentNAAlertOnMainThread(title: "Error!", message: "Invalid Email", buttonTitle: "OK")
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error{
                presentNAAlertOnMainThread(title: "Error Password Reset!", message: error.localizedDescription, buttonTitle: "OK")
                return
            }
            presentNAAlertOnMainThread(title: "Password Reset", message: "The password reset link has been sent to your email address.", buttonTitle: "OK")
        }
        
    }
    
    
}
