//
//  JobListInteractor.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation

protocol JobListInteractorProtocol {
    
}

final class JobListInteractor: JobListInteractorProtocol {
    private let service: JobServiceProtocol
    
    init(service: JobServiceProtocol = JobService()) {
        self.service = service
    }
}
