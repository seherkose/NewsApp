//
//  SearchVC.swift
//  NewsApp
//
//  Created by Seher Köse on 5.09.2023.
//

import UIKit

class SearchVC: UIViewController {
   
    let logoImageView = UIImageView()
    let countryTextField = NATextField()
    let callToActionButton = NAButton(backgroundColor: .mediumBlue, title: Constants.SearchVC.showNews)
    
    var isNewsTitleEntered: Bool{
        return !countryTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .beige
    }
    
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushNewsListVC() {
        guard isNewsTitleEntered else {
            presentNAAlertOnMainThread(title: Constants.SearchVC.emptyCountry, message: Constants.SearchVC.emptyCountryMessage , buttonTitle: Constants.SearchVC.okMessage)
            return
        }
        
        var selectedCountryCode: String?
        if let country = countryTextField.text {
            switch country {
            case "Turkey":
                selectedCountryCode = CountryCode.turkey.rawValue
            case "United States":
                selectedCountryCode = CountryCode.unitedStates.rawValue
            case "UNITED STATES":
                selectedCountryCode = CountryCode.unitedStates.rawValue
            case "Japan":
                selectedCountryCode = CountryCode.japan.rawValue
            default:
                selectedCountryCode = country
            }
        }
        let newsListVC = NewsListVC()
        newsListVC.countryName = selectedCountryCode
        newsListVC.title = countryTextField.text
        navigationController?.pushViewController(newsListVC, animated: true)
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 450)
        ])
    }
    
    func configureTextField(){
        view.addSubview(countryTextField)
        countryTextField.delegate = self
        NSLayoutConstraint.activate([
            countryTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            countryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            countryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            countryTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushNewsListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            callToActionButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushNewsListVC()
        return true
    }
    
}

