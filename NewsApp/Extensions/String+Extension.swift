//
//  String+Extension.swift
//  NewsApp
//
//  Created by Seher Köse on 17.09.2023.
//

import Foundation
class Validator {
    static func isValidEmail(for email: String) -> Bool{
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
        
    }
    static func isValidUsername(for username: String) -> Bool{
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameFormat         = "\\w{4,24}"
        let usernamePredicate      = NSPredicate(format: "SELF MATCHES %@", usernameFormat)
        return usernamePredicate.evaluate(with: username)
    }
    
    static func isValidPassword(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordFormat      = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{6,32}$"
        let passwordPredicate   = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: password)
    }
    
}
