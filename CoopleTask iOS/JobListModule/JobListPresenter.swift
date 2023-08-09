//
//  JobListPresenter.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation
import Combine

enum JobListViewEvent {
    case viewDidLoad
    case loadNextPage
}

protocol JobListPresenterProtocol {
    var viewEventSubject: PassthroughSubject<JobListViewEvent, Never> { get }
    var jobItemsSubject: PassthroughSubject<[JobItem], Error> { get }
    var isFetchingSubject: PassthroughSubject<Bool, Never> { get }
}

final class JobListPresenter: JobListPresenterProtocol {
    let viewEventSubject = PassthroughSubject<JobListViewEvent, Never>()
    let jobItemsSubject = PassthroughSubject<[JobItem], Error>()
    let isFetchingSubject = PassthroughSubject<Bool, Never>()
    
    private let interactor: JobListInteractorProtocol
    private var jobItems = [JobItem]() {
        didSet {
            jobItemsSubject.send(jobItems)
        }
    }
    private var cancellables: Set<AnyCancellable> = []
    
    init(interactor: JobListInteractorProtocol) {
        self.interactor = interactor
        
        subscribeOnViewEvent()
        subscribeOnJobItems()
    }
    
    private func subscribeOnJobItems() {
        interactor.jobItemsSubject
            .sink { [weak self] completion in
                self?.isFetchingSubject.send(false)
                if case .failure(let error) = completion {
                    self?.jobItemsSubject.send(completion: .failure(error))
                }
            } receiveValue: { [weak self] items in
                self?.jobItems.append(contentsOf: items)
                self?.isFetchingSubject.send(false)
            }.store(in: &cancellables)
    }
    
    private func subscribeOnViewEvent() {
        viewEventSubject.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.fetchJobItems()
            case .loadNextPage:
                self?.fetchJobItems(nextPage: true)
            }
        }.store(in: &cancellables)
    }
    
    private func fetchJobItems(nextPage: Bool = false) {
        isFetchingSubject.send(true)
        interactor.fetchJobItems(nextPage: nextPage)
    }
}
