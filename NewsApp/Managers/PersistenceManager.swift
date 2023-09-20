
//
//  PersistenceManager.swift
//  NewsApp
//
//  Created by Seher Köse on 11.09.2023.
//

import Foundation

enum PersistenceActionType{
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "Favorites"
    }
    
    static func updateWith(favorite: Article, actionType: PersistenceActionType, completed: @escaping (NAError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    // Check if the article is already in favorites
                    if !favorites.contains(where: { $0.url == favorite.url }) {
                        favorites.append(favorite)
                    }
                case .remove:
                    favorites.removeAll {$0.url == favorite.url }
                }
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Article], NAError>) -> Void) {
        guard let favoritesData = defaults.data(forKey: Keys.favorites) else {
            completed(.success([])) // Return an empty array if no favorites found
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Article].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unabletoFavorite))
        }
    }
    
    static func save(favorites: [Article]) -> NAError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unabletoFavorite
        }
    }
    static func isArticleInFavorites(articleURL: String, completed: @escaping (Result<Bool, NAError>) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                let isArticleAlreadyInFavorites = favorites.contains { $0.url == articleURL }
                completed(.success(isArticleAlreadyInFavorites))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
}
