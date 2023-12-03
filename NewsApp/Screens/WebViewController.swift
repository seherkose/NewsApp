//
//  WebViewController.swift
//  NewsApp
//
//  Created by Seher Köse on 15.09.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    private let urlString: String
    
    init(with urlString: String){
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        guard let url = URL(string: self.urlString) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.webView.load(URLRequest(url: url))
    }
    
    private func setUpUI(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.WebViewControllerVC.done, style: .done, target: self, action: #selector(didTappedDone))
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        self.view.addSubview(webView)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    @objc private func didTappedDone(){
        self.dismiss(animated: true, completion: nil)
    }
}
