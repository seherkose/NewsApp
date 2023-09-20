//
//  NABodyLabel.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import UIKit

class NABodyLabel: UILabel {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (textAlignment: NSTextAlignment, fontSize: CGFloat, textColor: UIColor){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont(name: "HelveticaNeue", size: fontSize)
        self.textColor = textColor
        
        configure()
    }
    private func configure(){
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }


}
