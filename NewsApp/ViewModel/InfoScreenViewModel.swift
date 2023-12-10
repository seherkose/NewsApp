//
//  InfoScreenViewModel.swift
//  NewsApp
//
//  Created by Seher Köse on 10.12.2023.
//

import Foundation
protocol InfoScreenViewModelDelegate: AnyObject{
    func articleURLisMissing()
    func articleURLisNotMissing()
    func wentWrongMessage(_ message: String)
    func successMessage()
    func articleNotFound()
    func errorFetchingNews(_ message: String)
    func alreadyFavorites()
    func errorMessage(_ message: String)
}

class InfoScreenViewModel{
    
    var countryName: String!
    var page = 1
    
    var articleTitle: String?
    var articleImageURL: String?
    var articleDescription: String?
    var articleDate: String?
    var articleAuthor: String?
    var articleURL: String?
    var articleContent: String?
    
    
    weak var delegate: InfoScreenViewModelDelegate?
    
    init(){}
    
    func favoriteButton(){
        
        guard let articleURL = articleURL else {
            //print("Article URL is missing")
            delegate?.articleURLisMissing()
            return
        }
        //print("Article url is not missing")
        delegate?.articleURLisNotMissing()
        
        PersistenceManager.isArticleInFavorites(articleURL: articleURL) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let isArticleAlreadyInFavorites):
                if isArticleAlreadyInFavorites {
                    delegate?.alreadyFavorites()
                } else {
                    self.addArticleToFavorites(articleURL: articleURL)
                }
                
            case .failure(let error):
                delegate?.errorMessage(error.rawValue)
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
                            delegate?.wentWrongMessage(error.rawValue)
                        } else {
                            
                            delegate?.successMessage()
                        }
                    }
                } else {
                    delegate?.articleNotFound()
                    
                }
                
            case .failure(let error):
                delegate?.errorFetchingNews(error.rawValue)
            }
        }
    }
    
}

