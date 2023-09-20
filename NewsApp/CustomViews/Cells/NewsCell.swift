//
//  NewsCell.swift
//  NewsApp
//
//  Created by Seher Köse on 7.09.2023.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    static let reuseID = "NewsCell"
    let newsImageView = NAImageView(frame: .zero)
    let titleLabel = NATitleLabel(textAlignment: .left, fontSize: 20, textColor: .black)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(article: Article){
        titleLabel.text = article.title
        newsImageView.downloadImage(from: article.urlToImage ?? "00")
    }
    
    private func configure(){
        backgroundColor = UIColor(hex: "F8F0E5")
        addSubview(newsImageView)
        addSubview(titleLabel)
        
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: -80),
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
