//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Seher Köse on 19.09.2023.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject{
    func showEmailValidationError()
    func showPasswordValidationError()
    func showErrorSignIn(_ message: String)
    func successLogin()
}

struct LoginViewModel{
    
    weak var delegate: LoginViewModelDelegate?
    
    init(){
        
    }
    private func checkEmail(_ email: String) -> Bool{
        if !Validator.isValidEmail(for: email){
            delegate?.showEmailValidationError()
            return false
        }
        return true
    }
    
    private func checkPassword(_ password: String) -> Bool{
        if !Validator.isValidPassword(for: password){
            delegate?.showPasswordValidationError()
            return false
        }
        return true
    }
    
    func signIn(email: String, password: String){
        let loginRequest = LoginUserRequest(
            email: email,
            password: password)
        
        if checkEmail(email), checkPassword(password){
            AuthService.shared.signIn(with: loginRequest) { error in
                
                if let error = error{
                    delegate?.showErrorSignIn(error.localizedDescription)
                    return
                }
                delegate?.successLogin()
            }
        }
    }
    
}
