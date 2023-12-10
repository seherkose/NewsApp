//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Seher Köse on 7.12.2023.


import Foundation
import UIKit

protocol NewsListViewModelDelegate: AnyObject{
    func showLoadingView()
    func dismissLoadingView()
    func showBadStuffAlert(_ message: String)
    func updateDataFromViewModel()
}

class NewsListViewModel{
    
    weak var delegate: NewsListViewModelDelegate?

    init(){
    }
    
    private var hasMoreNews = true
    var articleData: [Article] = []
    
    
        func getNews(countryName: String, page: Int) {
            //showLoadingView()
            if !hasMoreNews{
                return
            }

            delegate?.showLoadingView()
            
            NetworkManager.shared.getNews(for: countryName, page: page) { [weak self] result in
                // for unwrapping optional self result of weak
                guard let self = self else {
                    return
                }
                //self.dismissLoadingView()
                delegate?.dismissLoadingView()
                
                switch result {
                case .success(let news):
                    if news.articles.count < 10 {
                        self.hasMoreNews = false
                    }
                    
                    self.articleData = news.articles
 //                  let uniqueArticle = Array(Set(news.articles))
 //                   self.articleData.append(contentsOf: uniqueArticle)
                    
                   // self.updateData(on: self.articleData)
                    
                    delegate?.updateDataFromViewModel()
    
                case .failure(let error):
                    delegate?.showBadStuffAlert(error.rawValue)
                    
                    delegate?.dismissLoadingView()
                }
            }
        }
    
}





