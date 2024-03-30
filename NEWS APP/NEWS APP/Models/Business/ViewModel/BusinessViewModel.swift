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
}