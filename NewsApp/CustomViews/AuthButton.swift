//
//  AuthButton.swift
//  NewsApp
//
//  Created by Seher Köse on 15.09.2023.
//

import UIKit

class AuthButton: UIButton {
    
    enum FontSize{
        case big
        case med
        case small
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = hasBackground ? UIColor(hex: "235B8C") : .clear
        
        let titleColor: UIColor = hasBackground ? .white : UIColor(hex: "235B8C")
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize{
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
