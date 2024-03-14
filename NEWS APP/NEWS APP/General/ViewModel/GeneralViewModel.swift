//
//  GeneralViewModel.swift
//  NEWS APP
//
//  Created by Vova on 12.03.2024.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadData: (() -> Void)?
    
    //  MARK: - Properties
    var numberOfCells: Int {
        articles.count
    }
    
    private var articles: [ArticleResponseObject] = [] {
        didSet {
            reloadData?()
        }
    }
    
    init() {
        loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        let article = articles[row]
        return ArticleCellViewModel(article: article)
    }
    
    private func loadData() {
        // TODO: load Data
        setupMockObject()
    }
    
    private func setupMockObject() {
        articles = [
            ArticleResponseObject(title: "First object title", description: "First object description in the mock object", urlToImage: "...", publishedAt: "23.01.2012"),
            ArticleResponseObject(title: "Second object title", description: "Second object description in the mock object", urlToImage: "...", publishedAt: "24.01.2012"),
            ArticleResponseObject(title: "Third object title", description: "Third object description in the mock object", urlToImage: "...", publishedAt: "25.01.2012"),
            ArticleResponseObject(title: "Fourth object title", description: "Fourth object description in the mock object", urlToImage: "...", publishedAt: "26.01.2012"),
            ArticleResponseObject(title: "Fifth object title", description: "Fifth object description in the mock object", urlToImage: "...", publishedAt: "27.01.2012"),
            ArticleResponseObject(title: "Sixth object title", description: "Sixth object description in the mock object", urlToImage: "...", publishedAt: "28.01.2012"),
            ArticleResponseObject(title: "Seventh object title", description: "Seventh object description in the mock object", urlToImage: "...", publishedAt: "29.01.2012"),
            ArticleResponseObject(title: "Eighth object title", description: "Eighth object description in the mock object", urlToImage: "...", publishedAt: "30.01.2012"),
            ArticleResponseObject(title: "Ninth object title", description: "Ninth object description in the mock object", urlToImage: "...", publishedAt: "31.01.2012"),
            ArticleResponseObject(title: "Tenth object title", description: "Tenth object description in the mock object", urlToImage: "...", publishedAt: "01.02.2012")
        ]
    }
}
