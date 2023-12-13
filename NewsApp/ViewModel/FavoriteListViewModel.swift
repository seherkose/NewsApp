//
//  FavoriteListViewModel.swift
//  NewsApp
//
//  Created by Seher Köse on 13.12.2023.
//

import Foundation

protocol FavoriteListViewModelDelegate: AnyObject{
    func showEmptyState()
    func reloadData()
    func bringSubviewToFront()
    func presentNAAlertOnMainThread(_ message: String)
}

class FavoriteListViewModel{
    
    init(){
    }
    
    weak var delegate: FavoriteListViewModelDelegate?
    var favorites: [Article] = []
    
    
        func getFavorites(){
            PersistenceManager.retrieveFavorites{ [weak self] result in
                guard let self = self else {return}
                switch result{
                case .success(let favorites):
                    if favorites.isEmpty{
                        delegate?.showEmptyState()
                    }else {
                        self.favorites = favorites
                        DispatchQueue.main.async {
                            //self.tableView.reloadData()
                            self.delegate?.reloadData()
                            //self.view.bringSubviewToFront(self.tableView)
                            self.delegate?.bringSubviewToFront()
                        }
                    }
                case .failure(let error):
                    delegate?.presentNAAlertOnMainThread(error.rawValue)
                }
            }
        }
}
