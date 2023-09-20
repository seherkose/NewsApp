//
//  SideBarCell.swift
//  NewsApp
//
//  Created by Seher Köse on 13.09.2023.
//

import UIKit

class SideBarCell: UITableViewCell {
    
    static let reuseID = "SideBarCell"
    //let newsImageView = NAImageView(frame: .zero)
    let titleLabel = NATitleLabel(textAlignment: .left, fontSize: 20, textColor: .white)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubview(titleLabel)
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
}

