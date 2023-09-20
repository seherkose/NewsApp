//
//  InfoScreenVC.swift
//  NewsApp
//
//  Created by Seher Köse on 8.09.2023.
//

import UIKit

class InfoScreenVC: UIViewController, UIScrollViewDelegate{
    let scrollView = UIScrollView()
    
    var countryName: String!
    var page = 1
    let titleLabel = NATitleLabel(textAlignment: .left, fontSize: 23, textColor: .black)
    let dateLabel = NATitleLabel(textAlignment: .left, fontSize: 20, textColor: .gray)
    let descriptionLabel = NATitleLabel(textAlignment: .left, fontSize: 19, textColor: .gray)
    let contentLabel = NABodyLabel(textAlignment: .left, fontSize: 18, textColor: .black)
    let authorLabel = NATitleLabel (textAlignment: .left, fontSize: 18, textColor: .darkGray)
    
    var articleTitle: String?
    var articleImageURL: String?
    var articleDescription: String?
    var articleDate: String?
    var articleAuthor: String?
    var articleURL: String?
    var articleContent: String?
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
        
    }()
    
    private let contentView: UIView = {
        let v = UIView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
        scrollView.delegate = self
    }
    
    
    func configureViewController(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        let favoriteButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.leftBarButtonItem = doneButton
        navigationItem.rightBarButtonItem = favoriteButton
        
        view.backgroundColor = UIColor(hex: "F8F0E5")
        
    }
    
    
    @objc func favoriteButtonTapped() {
        guard let articleURL = articleURL else {
            print("Article URL is missing")
            return
        }
        PersistenceManager.isArticleInFavorites(articleURL: articleURL) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let isArticleAlreadyInFavorites):
                if isArticleAlreadyInFavorites {
                    self.presentNAAlertOnMainThread(title: "Already Favorited", message: "This article is already in your favorites.", buttonTitle: "OK")
                } else {
                    self.addArticleToFavorites(articleURL: articleURL)
                }
                
            case .failure(let error):
                self.presentNAAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func addArticleToFavorites(articleURL: String) {
        NetworkManager.shared.getNews(for: countryName, page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                if let selectedArticle = news.articles.first(where: { $0.url == articleURL }) {
                    let title = selectedArticle.title
                    let favorite = Article(
                        author: selectedArticle.author,
                        title: title,
                        description: selectedArticle.description,
                        url: articleURL,
                        urlToImage: selectedArticle.urlToImage,
                        publishedAt: selectedArticle.publishedAt,
                        content: selectedArticle.content
                    )
                    PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                        guard let self = self else { return }
                        
                        if let error = error {
                            self.presentNAAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "OK")
                        } else {
                            self.presentNAAlertOnMainThread(title: "Success!", message: "You have successfully favorited this article 🎉", buttonTitle: "OK")
                        }
                    }
                } else {
                    self.presentNAAlertOnMainThread(title: "Error", message: "Selected article not found", buttonTitle: "OK")
                }
                
            case .failure(let error):
                self.presentNAAlertOnMainThread(title: "Error Fetching News", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configure() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -10),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -20),
        ])
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(articleImageView)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(contentLabel)
        self.view.addSubview(authorLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = articleTitle
        dateLabel.text = articleDate
        descriptionLabel.text = articleDescription
        authorLabel.text = "Author: \(articleAuthor ?? "00")"
        contentLabel.text = articleContent
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            articleImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            articleImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4),
            articleImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -4),
            articleImageView.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            contentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25),
            contentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            authorLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            authorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        if let imageURL = articleImageURL, let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.articleImageView.image = image
                    }
                }
            }.resume()
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
