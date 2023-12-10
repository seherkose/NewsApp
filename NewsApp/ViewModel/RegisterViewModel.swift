//
//  RegisterViewModel.swift
//  NewsApp
//
//  Created by Seher Köse on 4.12.2023.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject{
    func showUsernameValidationError()
    func showEmailValidatorError()
    func showPasswordValidatorError()
    func showErrorSignUp(_ message: String)
    func successSignUp()
}

struct RegisterViewModel{
    weak var delegate: RegisterViewModelDelegate?
    
    init(){}
    
    private func checkUserName(_ userName: String) -> Bool{
        //username check
        if !Validator.isValidUsername(for: userName){
            delegate?.showUsernameValidationError()
            return false
        }
        return true
        
    }
    private func checkEmail(_ email: String) -> Bool{
        
        //email check
        if !Validator.isValidEmail(for: email){
            delegate?.showEmailValidatorError()
            return false
        }
        return true
    }
    
    private func checkPassword(_ password: String) -> Bool{
        //password check
        if !Validator.isValidPassword(for: password){
            delegate?.showPasswordValidatorError()
            return false
        }
        return true
    }
    
    func signUp(username: String, email: String, password: String){
        let registerUserRequest = RegisterUserRequest(
            username: username,
            email: email,
            password: password
        )
        
        
        if checkUserName(username), checkEmail(email), checkUserName(password){
            
            AuthService.shared.registerUser(with: registerUserRequest) { wasRegistered, error in
                
                if let error = error{
                    delegate?.showErrorSignUp(error.localizedDescription)
                }
                
                if wasRegistered{
                    delegate?.successSignUp()
                }
            }
        }
    }
}
