//
//  SectionDataSource.swift
//  NEWS APP
//
//  Created by Vova on 20.03.2024.
//

import Foundation

protocol SectionDataSourceProtocol { }

struct SectionDataSource {
    var title: String?
    var items: [SectionDataSourceProtocol]
}
