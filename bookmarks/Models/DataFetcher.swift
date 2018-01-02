//
//  DataFetcher.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func data(for url: URL, completion: @escaping (Result<Data>)->())
}

enum DataFetcherError: Error {
    case emptyData()
    case invalidStatusCode(Int)
}

final class URLSessionDataFetcher: DataFetcher {
    let session: URLSession
    
    public init(session: URLSession? = nil) {
        self.session = session ?? URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func data(for url: URL, completion: @escaping (Result<Data>)->()) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.error(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        completion(.success(data))
                    } else {
                        completion(.error(DataFetcherError.emptyData()))
                    }
                } else {
                    completion(.error(DataFetcherError.invalidStatusCode(httpResponse.statusCode)))
                }
            }
        }
        task.resume()
    }
}
