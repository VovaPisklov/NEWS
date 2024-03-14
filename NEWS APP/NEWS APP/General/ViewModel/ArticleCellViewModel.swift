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
    var imageUrl: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        data = article.date
        imageUrl = article.urlToImage
    }
}
