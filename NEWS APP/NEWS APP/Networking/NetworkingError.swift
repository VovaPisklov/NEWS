//
//  NetworkingError.swift
//  NEWS APP
//
//  Created by Vova on 14.03.2024.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
