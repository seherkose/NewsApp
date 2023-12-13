//
//  ProfileInfoViewModel.swift
//  NewsApp
//
//  Created by Seher Köse on 13.12.2023.
//

import Foundation
protocol ProfileInfoViewModelDelegate: AnyObject{
    func errorMessage(_ message: String)
    func checkAuth()
}
class ProfileInfoViewModel{
    init(){}
    
    weak var delegate: ProfileInfoViewModelDelegate?
    
    func logOut(){
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else{return}
            if let error = error {
                delegate?.errorMessage(error.localizedDescription)
                return
            }
            delegate?.checkAuth()
        }
    }
    
}
