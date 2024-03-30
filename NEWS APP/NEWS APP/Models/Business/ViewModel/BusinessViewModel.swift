//
//  BusinessViewModel.swift
//  NEWS APP
//
//  Created by Vova on 19.03.2024.
//

import Foundation

final class BusinessViewModel: BaseNewsListViewModel {
    override func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        if sections.isEmpty {
            let firstSection = SectionDataSource(items: [viewModels.removeFirst()])
            let secondSection = SectionDataSource(items: viewModels)
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
}
