//
//  NewsResponseObject.swift
//  NEWS APP
//
//  Created by Vova on 14.03.2024.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
