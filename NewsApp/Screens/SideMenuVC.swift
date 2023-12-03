//
//  SideMenuVC.swift
//  NewsApp
//
//  Created by Seher Köse on 13.09.2023.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func selectCategory(_ category: String)
}
class SideMenuVC: UIViewController {
    
    weak var delegate: SideMenuDelegate?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SideBarCell.self, forCellReuseIdentifier: SideBarCell.reuseID)
        tableView.backgroundColor = .darkBlue
        tableView.layer.cornerRadius = 15
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideBarCell.reuseID) as! SideBarCell
        cell.titleLabel.text = Categories.allCases[indexPath.row].rawValue
        cell.backgroundColor = .darkBlue
        cell.selectionStyle  = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCategory = Categories.allCases[indexPath.row].rawValue
        delegate?.selectCategory(selectedCategory)
    }
}
