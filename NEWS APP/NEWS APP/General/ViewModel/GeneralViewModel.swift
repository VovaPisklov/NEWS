//
//  GeneralViewModel.swift
//  NEWS APP
//
//  Created by Vova on 12.03.2024.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    
    var showError: ((String) -> Void)? { get set }
    
    var reloadCell: ((Int) -> Void)? { get set }

    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadCell: ((Int) -> Void)?
    
    var showError: ((String) -> Void)?
    
    var reloadData: (() -> Void)?
    
    //  MARK: - Properties
    var numberOfCells: Int {
        articles.count
    }
    
    private var articles: [ArticleCellViewModel] = [] {
        didSet {
            guard articles.count != oldValue.count else { return } 
            DispatchQueue.main.sync {
                self.reloadData?()
            }
        }
    }
    
    init() {
        loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
    }
    
    private func loadData() {
        ApiManager.getNews { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let articles):
                self.articles = self.convertToCellViewModel(articles)
                self.loadImages()
            case .failure(let error):
                DispatchQueue.main.sync {
                    self.showError?(error.localizedDescription)
                }
            }
        }
        //        setupMockObject()
    }
    
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        articles.map { ArticleCellViewModel(article: $0) }
    }
    
    private func loadImages() {
        for (index, article) in articles.enumerated() {
            ApiManager.getImageData(url: article.imageUrl ?? "") { [weak self] result in
                DispatchQueue.main.sync {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func setupMockObject() {
        let articleObjects = createMockArticleObjects()
        articles = convertToCellViewModel(articleObjects)
    }
    
    private func createMockArticleObjects() -> [ArticleResponseObject] {
        return [
            ArticleResponseObject(title: "First object title", description: "First object description in the mock object", urlToImage: "...", date: "23.01.2012"),
            ArticleResponseObject(title: "Second object title", description: "Second object description in the mock object", urlToImage: "...", date: "24.01.2012"),
            ArticleResponseObject(title: "Third object title", description: "Third object description in the mock object", urlToImage: "...", date: "25.01.2012"),
            ArticleResponseObject(title: "Fourth object title", description: "Fourth object description in the mock object", urlToImage: "...", date: "26.01.2012"),
            ArticleResponseObject(title: "Fifth object title", description: "Fifth object description in the mock object", urlToImage: "...", date: "27.01.2012"),
            ArticleResponseObject(title: "Sixth object title", description: "Sixth object description in the mock object", urlToImage: "...", date: "28.01.2012"),
            ArticleResponseObject(title: "Seventh object title", description: "Seventh object description in the mock object", urlToImage: "...", date: "29.01.2012"),
            ArticleResponseObject(title: "Eighth object title", description: "Eighth object description in the mock object", urlToImage: "...", date: "30.01.2012"),
            ArticleResponseObject(title: "Ninth object title", description: "Ninth object description in the mock object", urlToImage: "...", date: "31.01.2012"),
            ArticleResponseObject(title: "Tenth object title", description: "Tenth object description in the mock object", urlToImage: "...", date: "01.02.2012")
        ]
    }
}
