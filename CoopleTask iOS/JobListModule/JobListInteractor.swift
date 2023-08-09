//
//  JobListInteractor.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation
import Combine

protocol JobListInteractorProtocol {
    func fetchJobItems(nextPage: Bool)
    var jobItemsSubject: PassthroughSubject<[JobItem], Error> { get }
}

final class JobListInteractor: JobListInteractorProtocol {
    let jobItemsSubject = PassthroughSubject<[JobItem], Error>()
    
    private let pageSize: Int
    private let service: JobServiceProtocol
    private var pageNum = 0
    private var total = -1
    private var cancellables: Set<AnyCancellable> = []
    
    init(pageSize: Int = 50, service: JobServiceProtocol = JobService()) {
        self.pageSize = pageSize
        self.service = service
    }
    
    func fetchJobItems(nextPage: Bool = false) {
        guard isFetchingAvaliable() else {
            jobItemsSubject.send(completion: .failure(CoopleError.noMoreObjects))
            return
        }
        if nextPage { pageNum += 1 }
        service.fetchJobItems(pageSize: pageSize, pageNum: pageNum)
            .map { response in
                self.total = response.total
                return response.items
            }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.jobItemsSubject.send(completion: .failure(error))
                }
            }, receiveValue: { [weak self] jobItems in
                self?.jobItemsSubject.send(jobItems)
            })
            .store(in: &cancellables)
    }
    
    private func isFetchingAvaliable() -> Bool {
        let lastPage = Int(ceil(Double(total) / Double(pageSize)))
        return pageNum <= lastPage
    }
}
