//
//  JobListConfigurator.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import UIKit

struct JobListConfigurator {
    func configure() -> UIViewController {
        let interactor = JobListInteractor()
        let presenter = JobListPresenter(interactor: interactor)
        let controller = JobListViewController(presenter: presenter)
        presenter.view = controller
        return controller
    }
}
