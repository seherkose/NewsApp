//
//  ForgotPasswordVC.swift
//  NewsApp
//
//  Created by Seher Köse on 15.09.2023.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    var viewModel = ForgotPasswordViewModel()
    
    private let headerView = AuthHeaderView(title: Constants.ForgotPasswordVC.headerForgotPassword, subTitle: Constants.ForgotPasswordVC.headerForgotPasswordSubTitle)
    private let emailField = AuthTextField(fieldType: .email)
    private let resetPasswordButton = AuthButton(title: Constants.ForgotPasswordVC.resetPassword, hasBackground: true, fontSize: .big)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setUpUI()
        self.resetPasswordButton.addTarget(self, action: #selector(didTappedResetPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setUpUI(){
        self.view.backgroundColor = .beige
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
    
    @objc private func didTappedResetPassword(){
        //let email = self.emailField.text ?? ""
        viewModel.resetPassword(email: self.emailField.text ?? "")
        //
        //        if !Validator.isValidEmail(for: email){
        //            presentNAAlertOnMainThread(title: Constants.ForgotPasswordVC.errorMessage, message: Constants.ForgotPasswordVC.invalidMail, buttonTitle: Constants.ForgotPasswordVC.okMessage)
        //            return
        //        }
        //
        //        AuthService.shared.forgotPassword(with: email) { [weak self] error in
        //            guard let self = self else { return }
        //            if let error = error{
        //                presentNAAlertOnMainThread(title: Constants.ForgotPasswordVC.passwordReset, message: error.localizedDescription, buttonTitle: Constants.ForgotPasswordVC.okMessage)
        //                return
        //            }
        //            presentNAAlertOnMainThread(title: Constants.ForgotPasswordVC.passwordResetTitle, message: Constants.ForgotPasswordVC.passwordResetMessage, buttonTitle: Constants.ForgotPasswordVC.okMessage)
        //        }
    }
}

extension ForgotPasswordVC: ForgotPasswordDelegate{
    func showPasswordResetMessage() {
        presentNAAlertOnMainThread(title: Constants.ForgotPasswordVC.passwordResetTitle, message: Constants.ForgotPasswordVC.passwordResetMessage, buttonTitle: Constants.ForgotPasswordVC.okMessage)
    }
    
    func showErrorPasswordReset(_ message: String) {
        presentNAAlertOnMainThread(title: Constants.ForgotPasswordVC.passwordReset, message: message, buttonTitle: Constants.ForgotPasswordVC.okMessage)
    }
    
    func showEmailError() {
        presentNAAlertOnMainThread(title: Constants.ForgotPasswordVC.errorMessage, message: Constants.ForgotPasswordVC.invalidMail, buttonTitle: Constants.ForgotPasswordVC.okMessage)
    }
    
}


