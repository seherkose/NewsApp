//
//  ForgotPasswordViewModel.swift
//  NewsApp
//
//  Created by Seher Köse on 10.12.2023.
//

import Foundation

protocol ForgotPasswordDelegate: AnyObject{
    func showEmailError()
    func showErrorPasswordReset(_ message: String)
    func showPasswordResetMessage()
}

class ForgotPasswordViewModel{
    weak var delegate: ForgotPasswordDelegate?
    
    init(){
    }
    
    private func checkEmail(_ email: String) -> Bool{
        if !Validator.isValidEmail(for: email){
            // presentNAAlertOnMainThread(title: Constants.ForgotPasswordVC.errorMessage, message: Constants.ForgotPasswordVC.invalidMail, buttonTitle: Constants.ForgotPasswordVC.okMessage)
            delegate?.showEmailError()
            return false
        }
        return true
    }
    
    func resetPassword(email: String){
        if checkEmail(email){
            AuthService.shared.resetPassword(with: email) { [weak self] error in
                guard let self = self else { return }
                
                if let error = error{
                    delegate?.showErrorPasswordReset(error.localizedDescription)
                    return
                }
                delegate?.showPasswordResetMessage()
            }
        }
        
    }
}
