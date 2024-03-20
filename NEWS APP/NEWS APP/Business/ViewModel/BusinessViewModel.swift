//
//  BusinessViewModel.swift
//  NEWS APP
//
//  Created by Vova on 19.03.2024.
//

import Foundation

protocol BusinessViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    
    var showError: ((String) -> Void)? { get set }
    
    var reloadCell: ((IndexPath) -> Void)? { get set }
    
    var sections: [SectionDataSource] { get }
    
    func loadData()
}

final class BusinessViewModel: BusinessViewModelProtocol {
    var reloadCell: ((IndexPath) -> Void)?
    
    var showError: ((String) -> Void)?
    
    var reloadData: (() -> Void)?
    
    //  MARK: - Properties
    private (set) var sections: [SectionDataSource] = [] {
        didSet {
            let sectionChangesDetected = sections.contains { newSection in
                guard let oldSection = oldValue.first(where: { $0.items.count != newSection.items.count }) else {
                    return false // Если секция не найдена в старом массиве с изменением количества элементов, то изменений нет
                }
                return true // Изменения найдены в количестве элементов в секции
            }
            
            if sectionChangesDetected {
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            }
        }
    }
    
    private var page = 0
    
    func loadData() {
        page += 1
        
        ApiManager.getNews(theme: .business, page: page) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let articles):
                self.convertToCellViewModel(articles)
                self.loadImages()
            case .failure(let error):
                DispatchQueue.main.sync {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        if sections.isEmpty {
            let firstSection = SectionDataSource(items: [viewModels.removeFirst()])
            let secondSection = SectionDataSource(items: viewModels)
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
    
    private func loadImages() {
        for (i, section) in sections.enumerated() {
            for (index, item) in section.items.enumerated() {
                if let article = item as? ArticleCellViewModel,
                   let url = article.imageUrl {
                    ApiManager.getImageData(url: url) { [weak self] result in
                        DispatchQueue.main.sync {
                            switch result {
                            case .success(let data):
                                if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
                                    article.imageData = data
                                }
                                self?.reloadCell?(IndexPath(row: index, section: i))
                            case .failure(let error):
                                self?.showError?(error.localizedDescription)
                            }
                        }
                    }
                }
            }
            
        }
    }
    
//    private func setupMockObject() {
//        let articleObjects = createMockArticleObjects()
//        
//        articles = convertToCellViewModel(articleObjects)
//    }
    
//    private func createMockArticleObjects() -> [ArticleResponseObject] {
//        return [
//            ArticleResponseObject(title: "First object title", description: "First object description in the mock object", urlToImage: "...", date: "23.01.2012"),
//            ArticleResponseObject(title: "Second object title", description: "Second object description in the mock object", urlToImage: "...", date: "24.01.2012"),
//            ArticleResponseObject(title: "Third object title", description: "Third object description in the mock object", urlToImage: "...", date: "25.01.2012"),
//            ArticleResponseObject(title: "Fourth object title", description: "Fourth object description in the mock object", urlToImage: "...", date: "26.01.2012"),
//            ArticleResponseObject(title: "Fifth object title", description: "Fifth object description in the mock object", urlToImage: "...", date: "27.01.2012"),
//            ArticleResponseObject(title: "Sixth object title", description: "Sixth object description in the mock object", urlToImage: "...", date: "28.01.2012"),
//            ArticleResponseObject(title: "Seventh object title", description: "Seventh object description in the mock object", urlToImage: "...", date: "29.01.2012"),
//            ArticleResponseObject(title: "Eighth object title", description: "Eighth object description in the mock object", urlToImage: "...", date: "30.01.2012"),
//            ArticleResponseObject(title: "Ninth object title", description: "Ninth object description in the mock object", urlToImage: "...", date: "31.01.2012"),
//            ArticleResponseObject(title: "Tenth object title", description: "Tenth object description in the mock object", urlToImage: "...", date: "01.02.2012")
//        ]
//    }
}
