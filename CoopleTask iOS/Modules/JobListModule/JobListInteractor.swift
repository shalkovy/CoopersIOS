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
    var isFetchingSubject: PassthroughSubject<Bool, Never> { get }
}

final class JobListInteractor: JobListInteractorProtocol {
    let jobItemsSubject = PassthroughSubject<[JobItem], Error>()
    let isFetchingSubject = PassthroughSubject<Bool, Never>()
    
    private let pageSize: Int
    private let service: JobServiceProtocol
    private var pageNum = 0
    private var total = -1
    private var isFetching = false
    private var cancellables: Set<AnyCancellable> = []
    
    init(pageSize: Int = 50, service: JobServiceProtocol = JobNetworkService()) {
        self.pageSize = pageSize
        self.service = service
    }
    
    func fetchJobItems(nextPage: Bool = false) {
        guard isFetchingAvaliable() else {
            return
        }
        isFetchingSubject.send(true)
        isFetching = true
        if nextPage { pageNum += 1 }
        service.fetchJobItems(pageSize: pageSize, pageNum: pageNum)
            .map(\.data)
            .map { response in
                self.total = response.total
                return response.items
            }
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.jobItemsSubject.send(completion: .failure(error))
                    self?.isFetchingSubject.send(false)
                    self?.isFetching = false
                }
            }, receiveValue: { [weak self] jobItems in
                self?.jobItemsSubject.send(jobItems)
                self?.isFetchingSubject.send(false)
                self?.isFetching = false
            })
            .store(in: &cancellables)
    }
    
    private func isFetchingAvaliable() -> Bool {
        guard !isFetching else { return false }
        let lastPage = Int(ceil(Double(total) / Double(pageSize)))
        return pageNum <= lastPage
    }
}
