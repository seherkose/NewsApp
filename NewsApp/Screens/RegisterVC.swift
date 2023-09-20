//
//  RegisterVC.swift
//  NewsApp
//
//  Created by Seher Köse on 14.09.2023.
//

import UIKit

class RegisterVC: UIViewController {
    
    private let headerView = AuthHeaderView(title: "SIGN UP", subTitle: "Create Your Account")
    
    private let usernameField = AuthTextField(fieldType: .username)
    private let emailField = AuthTextField(fieldType: .email)
    private let passwordField = AuthTextField(fieldType: .password)
    
    private let signUpButton = AuthButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    private let signInButton = AuthButton(title: "Already have an account? Sign In", fontSize: .med)
    
    //MARK: - TAŞINACAK
    private let termsTextView: UITextView={
        let attributedString = NSMutableAttributedString(string: "By creating an account, you agree to our Terms & Conditions and acknowledge that you have read the Privacy Policy.")
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue ]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor =  .label
        tv.isSelectable = true
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.delaysContentTouches = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textAlignment = .center
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.termsTextView.delegate = self
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpUI(){
        self.view.backgroundColor = UIColor(hex: "F8F0E5")
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(signInButton)
        self.view.addSubview(termsTextView)
        
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.usernameField.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.signInButton.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.termsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            self.usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.usernameField.heightAnchor.constraint(equalToConstant: 55),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 22),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            self.signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 22),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 44),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.termsTextView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 6),
            self.termsTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.termsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
            
        ])
        
    }
    
    @objc private func didTapSignUp(){
        let registerUserRequest = RegisterUserRequest(
            username: self.usernameField.text ?? "",
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        //username check
        if !Validator.isValidUsername(for: registerUserRequest.username){
            presentNAAlertOnMainThread(title: "Invalid Username", message: "Please enter a valid username!", buttonTitle: "OK")
            return
        }
        //email check
        if !Validator.isValidEmail(for: registerUserRequest.email){
            presentNAAlertOnMainThread(title: "Invalid Email", message: "Please enter a valid email!", buttonTitle: "OK")
            return
        }
        //password check
        if !Validator.isValidPassword(for: registerUserRequest.password){
            presentNAAlertOnMainThread(title: "Invalid Password", message: "Your password must be at least 6 character and must contain 1 character, 1 number, and 1 uppercase letter", buttonTitle: "OK")
            return
        }
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else{return}
            if let error = error{
                presentNAAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "OK")
            }
            if wasRegistered{
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                    sceneDelegate.checkAuthentication()
                }else{
                    presentNAAlertOnMainThread(title: "Error", message: error!.localizedDescription, buttonTitle: "OK")
                }
            }
            
            print(registerUserRequest)
        }
    }
    @objc private func didTapSignIn(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RegisterVC:  UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms"{
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=en-US")
            
        }else if URL.scheme == "privacy"{
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=en-US")
            
        }
        return true
    }
    
    private func showWebViewerController(with urlString: String){
        let vc = WebViewController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
    
}
