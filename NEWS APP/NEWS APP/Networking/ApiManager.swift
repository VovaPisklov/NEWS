//
//  ApiManager.swift
//  NEWS APP
//
//  Created by Vova on 14.03.2024.
//

import Foundation

final class ApiManager {
    enum Theme: String {
        case general = "everything?sources=bbc-news"
        case technology = "top-headlines?category=technology&country=us"
        case business = "top-headlines?category=business&country=us"
    }
    
    private static let apiKey = "38c84392c9574e9bb4c645b8adc61f93"
    private static let baseUrl = "https://newsapi.org/v2/"

    // Create url path and make request
    static func getNews(theme: Theme, page: Int, completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        let stringUrl = baseUrl + theme.rawValue + "&language=en&page=\(page)" + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        
        session.resume()
    }
    
    static func getImageData(url: String, 
                             completion: @escaping (Result<Data,
                                                    Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
            } else if let data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkingError.unknown))
            }
        }
        session.resume()
    }
    
    // Handle response
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<[ArticleResponseObject],
                                                              Error>) -> ()) {
        if let error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data {
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
                completion(.success(model.articles))
            }
            catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
