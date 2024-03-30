//
//  GeneralViewModel.swift
//  NEWS APP
//
//  Created by Vova on 12.03.2024.
//

import Foundation

final class GeneralViewModel: BaseNewsListViewModel {    
    override func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        if sections.isEmpty {
            let firstSection = SectionDataSource(items: viewModels)
            sections = [firstSection]
        } else {
            sections[0].items += viewModels
        }
    }
}
