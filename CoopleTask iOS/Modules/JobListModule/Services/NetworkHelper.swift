//
//  NetworkHelper.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 10/08/2023.
//

import Foundation
import Combine

protocol NetworkHelperProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

final class NetworkHelper: NetworkHelperProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        debugPrint(components)
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
