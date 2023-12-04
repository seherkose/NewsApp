
//  NewsListVC.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import UIKit

class NewsListVC: UIViewController {
    
    var viewModel = NewsListViewModel()
    
    var countryName: String!
    var article: [Article] = []
    var filteredNews: [Article] = []
    var page = 1
    var hasMoreNews = true
    var isSearching = false
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Article>!
    let sideMenuViewController = SideMenuVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        configureViewController()
        configureCollectionView()
        //getNews(countryName: countryName, page: page)
        viewModel.getNews(countryName: countryName, page: page)
        configureDataSource()
        confiureSearchController()
        
        let menuWidth: CGFloat = 250.0
        sideMenuViewController.delegate = self
        
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)
        
        sideMenuViewController.view.frame = CGRect(x: view.frame.width, y: 0, width: menuWidth, height: view.frame.height + 10)
        sideMenuViewController.view.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .beige
        tabBarController?.tabBar.barTintColor = .beige
        navigationController?.navigationBar.barTintColor = .beige
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .done, target: self, action: #selector(tappedSideMenu))
    }
    
    @objc func tappedSideMenu() {
        if let sideMenuViewController = children.first {
            let isHidden = sideMenuViewController.view.isHidden
            let targetX = isHidden ? self.view.frame.width - sideMenuViewController.view.frame.size.width : self.view.frame.width
            
            UIView.animate(withDuration: 0.3) {
                sideMenuViewController.view.frame.origin.x = targetX
            } completion: { _ in
                sideMenuViewController.view.isHidden = !isHidden
            }
        }
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .beige
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)
    }
    
    func confiureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a title.."
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = .darkPink
        searchController.searchBar.layer.cornerRadius = 20
        
    }
    
   
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Article>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, article)-> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
            cell.set(article: article)
            return cell
            
        })
    }
    
    
    //    func updateData(on news: [Article]) {
    //        // Filter out duplicate articles
    //        let uniqueArticles = Array(Set(news))
    //
    //        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
    //        snapshot.appendSections([.main])
    //        snapshot.appendItems(uniqueArticles)
    //
    //        DispatchQueue.main.async {
    //            self.dataSource.apply(snapshot, animatingDifferences: true)
    //        }
    //    }
    //}
    
    func updateData(on news: [Article]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(news)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
extension NewsListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height{
            // if hasMoreFollowers is true then continue from page
            guard hasMoreNews else {return}
            page += 1
            
            //getNews(countryName: countryName, page: page)
            viewModel.getNews(countryName: countryName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredNews : article
        let article = activeArray[indexPath.item]
        
        let destVC = InfoScreenVC()
        destVC.articleTitle = article.title
        destVC.articleImageURL = article.urlToImage
        destVC.articleDescription = article.description
        destVC.articleDate = article.publishedAt
        destVC.articleAuthor = article.author
        destVC.articleURL = article.url
        destVC.articleContent = article.content
        
        destVC.countryName = self.countryName
        let navController = UINavigationController(rootViewController: destVC)
        self.present(navController, animated: true, completion: nil)
    }
    
}
extension NewsListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else{return}
        isSearching = true
        filteredNews = article.filter{$0.title.lowercased().contains(filter.lowercased())}
        updateData(on: filteredNews)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: article)
    }
    
}
extension NewsListVC: SideMenuDelegate {
    func selectCategory(_ category: String) {
        UIView.animate(withDuration: 0.2, animations: {
        }) { [weak self] _ in
            guard let self = self else { return }
            
            self.tappedSideMenu()
            self.article = []
            self.page = 1
            
            NetworkManager.shared.getNewsByCategory(countryName: self.countryName, category: category, page: self.page) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let news):
                    let uniqueArticles = Array(Set(news.articles))
                    self.article.append(contentsOf: uniqueArticles)
                    self.updateData(on: self.article)
                    
                case .failure(let error):
                    print("Error fetching news by category: \(error)")
                }
            }
        }
    }
}

extension NewsListVC: NewListViewModel{
    func showBadStuffAlert(title: String, message: String, buttonTitle: String) {
        <#code#>
    }
    
    func updateData() {
        <#code#>
    }

}





