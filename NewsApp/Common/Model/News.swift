//
//  News.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import Foundation

// MARK: - Welcome
struct News: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable, Hashable, Equatable {
    //let source: Source
    let author: String?
    var title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}


