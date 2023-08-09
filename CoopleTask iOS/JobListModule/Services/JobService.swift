//
//  JobService.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation
import Combine

protocol JobServiceProtocol {
    func fetchJobItems(pageSize: Int, pageNum: Int) -> AnyPublisher<DataResponse, Error>
}

final class JobService: JobServiceProtocol {
    private let urlBuilder: CoopleJobsURLBuilder
    
    init(urlBuilder: CoopleJobsURLBuilder = CoopleJobsURLBuilder()) {
        self.urlBuilder = urlBuilder
    }
    
    func fetchJobItems(pageSize: Int, pageNum: Int) -> AnyPublisher<DataResponse, Error> {
        guard let url = urlBuilder.url(pageSize: pageSize, pageNum: pageNum) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: JobResponse.self, decoder: JSONDecoder())
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
