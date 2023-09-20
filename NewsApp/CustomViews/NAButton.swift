//
//  NAButton.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import UIKit

class NAButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor:UIColor, title:String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
