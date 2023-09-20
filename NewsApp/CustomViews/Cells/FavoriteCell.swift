//
//  FavoriteCell.swift
//  NewsApp
//
//  Created by Seher Köse on 12.09.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    let newsImageView = NAImageView(frame: .zero)
    let titleLabel = NATitleLabel(textAlignment: .left, fontSize: 20, textColor: .black)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Article){
        titleLabel.text = favorite.title
        newsImageView.downloadImage(from: favorite.urlToImage ?? "00")
    }
    
    private func configure(){
        addSubview(newsImageView)
        addSubview(titleLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            newsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            newsImageView.heightAnchor.constraint(equalToConstant: 60),
            newsImageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
}
