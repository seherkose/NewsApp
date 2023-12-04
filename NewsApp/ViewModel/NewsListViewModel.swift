//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Seher Köse on 4.12.2023.
//

import Foundation
protocol NewListViewModel: AnyObject{
    func showLoadingView()
    func dismissLoadingView()
    func showBadStuffAlert(title: String, message:String, buttonTitle:String)
    func updateData()
    
}
class NewsListViewModel {
    
    weak var delegate: NewListViewModel?
    
    init(){}
    
    private var hasMoreNews = true
    private var articleData: [Article] = []
    
    
    func getNews(countryName: String, page: Int) {
        //showLoadingView()
        if !hasMoreNews {
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
//                let uniqueArticles = Array(Set(news.articles))
//                self.article.append(contentsOf: uniqueArticles)
                //self.updateData(on: self.article)
                delegate?.updateData()
                
                
            case .failure(let error):
                //                    self.presentNAAlertOnMainThread(title: Constants.NewsListVC.badStuff, message: error.rawValue, buttonTitle: Constants.NewsListVC.okMessage)
                delegate?.showBadStuffAlert(title: Constants.NewsListVC.badStuff, message: error.rawValue, buttonTitle: Constants.NewsListVC.okMessage)
                delegate?.dismissLoadingView()
                
            }
        }
    }
}
