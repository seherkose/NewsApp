//
//  NATitleLabel.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import UIKit

class NATitleLabel: UILabel {

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
        self.textColor = textColor
        self.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        
        configure()
    }
    
    private func configure(){
        adjustsFontSizeToFitWidth = false
        //minimumScaleFactor = 0.90
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    

}
