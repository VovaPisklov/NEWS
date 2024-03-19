//
//  ApiManager.swift
//  NEWS APP
//
//  Created by Vova on 14.03.2024.
//

import Foundation

final class ApiManager {
    enum LanguageCode: String {
        case arabic = "ar"
        case german = "de"
        case english = "en"
        case spanish = "es"
        case french = "fr"
        case hindi = "hi"
        case italian = "it"
        case japanese = "ja"
        case dutch = "nl"
        case norwegian = "no"
        case portuguese = "pt"
        case russian = "ru"
        case swedish = "sv"
        case chinese = "zh"
    }
    
    enum NewsCategory: String {
        case business
        case entertainment
        case general
        case health
        case science
        case sports
        case technology
    }
    
    enum Endpoint: String {
        case everything = "everything"
        case topHeadlines = "top-headlines"
        case sources = "top-headlines/sources"
    }
    
    private static let apiKey = "38c84392c9574e9bb4c645b8adc61f93"
    private static let baseUrl = "https://newsapi.org/v2/"
    private static let path: Endpoint = .everything
    private static let languageCode: LanguageCode = .english

    // Create url path and make request
    static func getNews(completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        let stringUrl = baseUrl + path.rawValue + "?sources=bbc-news" + "&language=\(languageCode.rawValue)" + "&apiKey=" + apiKey
        
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
