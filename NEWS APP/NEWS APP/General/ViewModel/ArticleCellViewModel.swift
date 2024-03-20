//
//  ArticleCellViewModel.swift
//  NEWS APP
//
//  Created by Vova on 14.03.2024.
//

import Foundation

final class ArticleCellViewModel: SectionDataSourceProtocol {
    let title: String
    let description: String?
    let date: String
    var imageUrl: String?
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        date = article.date
        imageUrl = article.urlToImage
    }
}
