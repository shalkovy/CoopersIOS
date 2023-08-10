//
//  JobNetworkService.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation
import Combine

protocol JobServiceProtocol {
    func fetchJobItems(pageSize: Int, pageNum: Int) -> AnyPublisher<JobResponse, Error>
}

final class JobNetworkService: JobServiceProtocol {
    private let helper: NetworkHelperProtocol
    
    init(helper: NetworkHelperProtocol = NetworkHelper()) {
        self.helper = helper
    }
    
    func fetchJobItems(pageSize: Int, pageNum: Int) -> AnyPublisher<JobResponse, Error> {
        let endpoint = CoopleEndpoint.getData(pageNumber: pageNum, pageSize: pageSize)
        return helper.request(endpoint: endpoint)
    }
}
