//
//  NATextField.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import UIKit

class NATextField: UITextField {
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        backgroundColor = UIColor(hex: "EADBC8")
        autocorrectionType = .no
        returnKeyType = .go
        placeholder = "Enter a country for news!"
        
    }
    

}
