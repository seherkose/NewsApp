//
//  FavoritesListVC.swift
//  NewsApp
//
//  Created by Seher Köse on 5.09.2023.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    var viewModel = FavoriteListViewModel()
    
    let tableView = UITableView()
    //var favorites: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        configureViewController()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavorites()
    }
    
    func configureViewController(){
        view.backgroundColor = .beige
        title = Constants.FavoritesListVC.favoriteNews
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        tableView.backgroundColor = .beige
    }
    
}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = viewModel.favorites[indexPath.row]
        cell.set(favorite: favorite)
        cell.backgroundColor = .beige
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = viewModel.favorites[indexPath.row]
        let destVC = InfoScreenVC()
        
        destVC.viewModel.articleTitle = favorite.title
        destVC.viewModel.articleImageURL = favorite.urlToImage
        destVC.viewModel.articleDescription = favorite.description
        destVC.viewModel.articleDate = favorite.publishedAt
        destVC.viewModel.articleAuthor = favorite.author
        destVC.viewModel.articleContent = favorite.content
        
        //        destVC.articleTitle = favorite.title
        //        destVC.articleImageURL = favorite.urlToImage
        //        destVC.articleDescription = favorite.description
        //        destVC.articleDate = favorite.publishedAt
        //        destVC.articleAuthor = favorite.author
        //        destVC.articleContent = favorite.content
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{return}
        let favorite = viewModel.favorites[indexPath.row]
        viewModel.favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self]error in
            guard let self = self else {return}
            guard let error = error else {return}
            self.presentNAAlertOnMainThread(title: Constants.FavoritesListVC.unableRemove , message: error.rawValue, buttonTitle: Constants.FavoritesListVC.okMessage)
        }
    }
}

extension FavoritesListVC: FavoriteListViewModelDelegate{
    func presentNAAlertOnMainThread(_ message: String) {
        self.presentNAAlertOnMainThread(title: Constants.FavoritesListVC.wentWrong, message: message, buttonTitle: Constants.FavoritesListVC.okMessage)
    }
 
    func bringSubviewToFront() {
        self.view.bringSubviewToFront(self.tableView)
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showEmptyState() {
        self.showEmptyStateView(with: Constants.FavoritesListVC.noFavorites, in: self.view)
    }

}
