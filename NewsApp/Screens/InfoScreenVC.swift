//
//  InfoScreenVC.swift
//  NewsApp
//
//  Created by Seher Köse on 8.09.2023.
//

import UIKit

class InfoScreenVC: UIViewController, UIScrollViewDelegate{
    
    var viewModel = InfoScreenViewModel()
    
    let scrollView = UIScrollView()
    
    //var countryName: String!
    var page = 1
    let titleLabel = NATitleLabel(textAlignment: .left, fontSize: 23, textColor: .black)
    let dateLabel = NATitleLabel(textAlignment: .left, fontSize: 20, textColor: .gray)
    let descriptionLabel = NATitleLabel(textAlignment: .left, fontSize: 19, textColor: .gray)
    let contentLabel = NABodyLabel(textAlignment: .left, fontSize: 18, textColor: .black)
    let authorLabel = NATitleLabel (textAlignment: .left, fontSize: 18, textColor: .darkGray)
    
    //var articleTitle: String?
    //var articleImageURL: String?
    //var articleDescription: String?
    //var articleDate: String?
    //var articleAuthor: String?
    //var articleURL: String?
    //var articleContent: String?
    
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
        
        viewModel.delegate = self
        
        configureViewController()
        configure()
        scrollView.delegate = self
    }
    
    func configureViewController(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        let favoriteButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.leftBarButtonItem = doneButton
        navigationItem.rightBarButtonItem = favoriteButton
        
        view.backgroundColor = .beige
    }
    
    @objc func favoriteButtonTapped() {
        viewModel.favoriteButton()
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
  
        
        titleLabel.text = viewModel.articleTitle
        dateLabel.text = viewModel.articleDate
        descriptionLabel.text = viewModel.articleDescription
        authorLabel.text = "Author: \(viewModel.articleAuthor ?? "00")"
        contentLabel.text = viewModel.articleContent
        
        
        //        titleLabel.text = articleTitle
        //        dateLabel.text = articleDate
        //        descriptionLabel.text = articleDescription
        //        authorLabel.text = "Author: \(articleAuthor ?? "00")"
        //        contentLabel.text = articleContent
        
        
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
        
        if let imageURL = viewModel.articleImageURL, let url = URL(string: imageURL) {
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

extension InfoScreenVC: InfoScreenViewModelDelegate{
    func errorMessage(_ message: String) {
        self.presentNAAlertOnMainThread(title: Constants.InfoScreen.errorMessage, message: message, buttonTitle: Constants.InfoScreen.okMessage)
    }
    
    func alreadyFavorites() {
        self.presentNAAlertOnMainThread(title: Constants.InfoScreen.alreadyFavorited, message: Constants.InfoScreen.alreadyFavoritedMessage, buttonTitle: Constants.InfoScreen.okMessage)
    }
    
    func errorFetchingNews(_ message: String) {
        self.presentNAAlertOnMainThread(title: Constants.InfoScreen.errorFetchingNews, message: message , buttonTitle: Constants.InfoScreen.okMessage)
    }
    
    func articleNotFound() {
        self.presentNAAlertOnMainThread(title: Constants.InfoScreen.errorMessage, message: Constants.InfoScreen.articleNotFound, buttonTitle: Constants.InfoScreen.okMessage)
    }
    
    func successMessage() {
        self.presentNAAlertOnMainThread(title: Constants.InfoScreen.successTitle, message: Constants.InfoScreen.successMessage, buttonTitle: Constants.InfoScreen.okMessage)
    }
    
    func wentWrongMessage(_ message: String) {
        self.presentNAAlertOnMainThread(title: Constants.InfoScreen.wentWrongMessage, message: message, buttonTitle: Constants.InfoScreen.okMessage)
    }
    
    func articleURLisMissing() {
        print("Article URL is missing")
    }
    
    func articleURLisNotMissing() {
        print("Article url is not missing")
    }
    
    
}
