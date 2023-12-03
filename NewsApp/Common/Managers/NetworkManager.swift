//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import UIKit
class NetworkManager{
    
    static let shared = NetworkManager()
    private let baseURL = "https://newsapi.org/v2/"
    let cache = NSCache<NSString, UIImage>()
    private init(){}
    
    func getNews(for countryName: String, page: Int, completed: @escaping(Result <News, NAError>) -> Void){
        let endpoint = baseURL + "top-headlines?country=\(countryName)&apiKey=d3c775be4ab741ce9094e54edf9222f1&pageSize=20&page=\(page)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidResponse))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completed(.failure(.invalidResponse))
                return
            }
            if httpResponse.statusCode != 200 {
                completed(.failure(.invalidServer))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let news = try decoder.decode(News.self, from: data)
                completed(.success(news))
                
            }catch{
                completed(.failure(.invalidDecodedData))
            }
        }
        task.resume()
    }
    
    func getNewsByCategory(countryName: String, category: String, page: Int, completed: @escaping (Result<News, NAError>) -> Void) {
        let endpoint = baseURL + "top-headlines?country=\(countryName)&category=\(category)&apiKey=d3c775be4ab741ce9094e54edf9222f1&pageSize=20&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidResponse))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completed(.failure(.invalidResponse))
                return
            }
            
            if httpResponse.statusCode != 200 {
                completed(.failure(.invalidServer))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let news = try decoder.decode(News.self, from: data)
                completed(.success(news))
            } catch {
                completed(.failure(.invalidDecodedData))
            }
        }
        task.resume()
    }
}


