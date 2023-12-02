//
//  ProfileInfoVC.swift
//  NewsApp
//
//  Created by Seher Köse on 5.09.2023.
//

import UIKit

class ProfileInfoVC: UIViewController {
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let label = NATitleLabel(textAlignment: .center, fontSize: 20, textColor: .gray)
    private let logOutButton = AuthButton(title: "Log Out", hasBackground: true, fontSize: .big)
    private let forgotPasswordButton = AuthButton(title: "Change Password", hasBackground: true, fontSize: .big)
    
    private let termsTextView: UITextView={
        let attributedString = NSMutableAttributedString(string: "Terms & Conditions\n Privacy Policy")
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor =  .label
        tv.isSelectable = true
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.delaysContentTouches = false
        tv.font = UIFont.systemFont(ofSize: 20)
        tv.textAlignment = .center
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "F8F0E5")
        //showLoadingView()
        self.termsTextView.delegate = self
        setupUI()
        
//        AuthService.shared.fetchUser { [weak self] authuser, error in
//            guard let self = self else {return}
//            if let error = error{
//                presentNAAlertOnMainThread(title: "Error!", message: "Fetching User Error", buttonTitle: "OK")
//                return
//            }
//            if let authuser = authuser {
//                dismissLoadingView()
//                setupUI()
//                self.label.text = "Username: \n \(authuser.username)\n\n E-mail address:\n \(authuser.email)"
//            }
//        }
        
    }
    private func setupUI() {
        view.addSubview(headerImageView)
        view.addSubview(label)
        view.addSubview(logOutButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview( termsTextView)
        
        logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        termsTextView.delegate = self
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 222),
            
            label.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 30),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            logOutButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
            logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 20),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            termsTextView.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 30),
            termsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
        ])
    }
    
    @objc private func didTapLogOut(){
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else{return}
            if let error = error {
                presentNAAlertOnMainThread(title: "ERROR", message: error.localizedDescription, buttonTitle: "OK")
                return 
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                sceneDelegate.checkAuthentication()
            }
        }
        
    }
    
    @objc private func didTapForgotPassword(){
        let vc = ForgotPasswordVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileInfoVC:  UITextViewDelegate{
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


