//
//  JobListViewController.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import UIKit
import Combine

protocol JobListViewProtocol: UIViewController {}

class JobListViewController: UIViewController, JobListViewProtocol {
    enum Section { case main }
    
    // MARK: - Properties
    
    private let presenter: JobListPresenterProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var dataSource: UITableViewDiffableDataSource<Section, JobItem> = {
        UITableViewDiffableDataSource<Section, JobItem>(tableView: tableView) { tableView, indexPath, jobItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: JobItemCell.reuseId, for: indexPath) as! JobItemCell
            cell.update(with: jobItem)
            return cell
        }
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(JobItemCell.self, forCellReuseIdentifier: JobItemCell.reuseId)
        tableView.delegate = self
        tableView.tableFooterView = activity
        return tableView
    }()
    
    private let activity = UIActivityIndicatorView(style: .medium)
    
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
        presenter.viewEventSubject.send(.viewDidLoad)
        configureUI()
        setupSubscriptions()
    }
    
    // MARK: - Private
    
    private func setupSubscriptions() {
        subscribeOnJobItems()
        subsribeOnFetching()
    }
    
    private func configureUI() {
        view.addSubview(tableView)
    }
    
    private func subscribeOnJobItems() {
        presenter.jobItemsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.showAlert(with: error.localizedDescription)
                }
            } receiveValue: { [weak self] items in
                self?.update(with: items)
            }.store(in: &cancellables)
    }
    
    private func subsribeOnFetching() {
        presenter.isFetchingSubject
            .sink { [weak self] isFetching in
                self?.updateActivity(isFetching)
            }.store(in: &cancellables)
    }
    
    private func update(with jobItems: [JobItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, JobItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(jobItems, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func updateActivity(_ isFetching: Bool) {
        isFetching ? activity.startAnimating() : activity.stopAnimating()
    }
}

extension JobListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            presenter.viewEventSubject.send(.loadNextPage)
        }
    }
}
