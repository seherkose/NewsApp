
//
//  LoginVC.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import UIKit

class LoginVC: UIViewController {
    
    
    private let headerView = AuthHeaderView(title: Constants.Login.headerSignIn, subTitle: Constants.Login.headerHeadLine)
    private let emailField = AuthTextField(fieldType: .email)
    private let passwordField = AuthTextField(fieldType: .password)
    private let signInButton = AuthButton(title: Constants.Login.buttonSignIn, hasBackground: true, fontSize: .big)
    private let newUserButton = AuthButton(title: Constants.Login.buttonNewUser, fontSize: .med)
    private let forgotPasswordButton = AuthButton(title: Constants.Login.buttonForgotPassword, fontSize: .small)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpUI(){
        self.view.backgroundColor = UIColor(hex: "F8F0E5")
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 11),
            self.newUserButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.newUserButton.heightAnchor.constraint(equalToConstant: 44),
            self.newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 6),
            self.forgotPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            self.forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
        ])
        
    }
    @objc private func didTapSignIn(){
        let loginRequest = LoginUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? "")
        //email check
        if !Validator.isValidEmail(for: loginRequest.email){
            presentNAAlertOnMainThread(title: Constants.Login.invalidEmail, message: Constants.Login.invalidEmailMessage, buttonTitle: Constants.Login.okMessage)
            return
        }
        //password check
        if !Validator.isValidPassword(for: loginRequest.password){
            presentNAAlertOnMainThread(title: Constants.Login.invalidPassword, message: Constants.Login.invalidPasswordMessage, buttonTitle: Constants.Login.okMessage)
            return
        }
        AuthService.shared.signIn(with: loginRequest) { [weak self] error in
            guard let self = self else{return}
            if let error = error{
                presentNAAlertOnMainThread(title: Constants.Login.signInError, message: error.localizedDescription, buttonTitle: Constants.Login.okMessage)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                sceneDelegate.checkAuthentication()
            }else{
                presentNAAlertOnMainThread(title: Constants.Login.errorMessage, message: error!.localizedDescription, buttonTitle: Constants.Login.okMessage)
            }
        }
    }
    
    @objc private func didTapNewUser(){
        let vc = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword(){
        let vc = ForgotPasswordVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

