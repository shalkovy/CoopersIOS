//
//  JobListViewController.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import UIKit

protocol JobListViewProtocol: UIViewController {
    
}

class JobListViewController: UIViewController, JobListViewProtocol {
    // MARK: - Properties
    
    private let presenter: JobListPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: JobListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}
