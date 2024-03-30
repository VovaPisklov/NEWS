//
//  NewsDetailsViewModel.swift
//  NEWS APP
//
//  Created by Vova on 15.03.2024.
//

import Foundation

protocol NewsDetailsViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var date: String { get }
    var imageData: Data? { get }
}

final class NewsDetailsViewModel: NewsDetailsViewModelProtocol {
    let title: String
    let description: String
    let date: String
    let imageData: Data?
    
    
    init(article: ArticleCellViewModel) {
        title = article.title
        description = article.description ?? ""  
        date = article.date
        imageData = article.imageData
    }
}
