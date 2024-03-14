//
//  ArticleCellViewModel.swift
//  NEWS APP
//
//  Created by Vova on 14.03.2024.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let data: String
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        data = article.publishedAt
    }
}
