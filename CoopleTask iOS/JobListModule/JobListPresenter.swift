//
//  JobListPresenter.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation

protocol JobListPresenterProtocol {
    
}

final class JobListPresenter: JobListPresenterProtocol {
    weak var view: JobListViewProtocol?
    private let interactor: JobListInteractorProtocol
    
    init(interactor: JobListInteractorProtocol) {
        self.interactor = interactor
    }
    
}
