//
//  ViewController.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//

import UIKit
import SnapKit
import Combine

class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    
    weak var coordinator: SearchSceneCoordinator?
    
    private lazy var searchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            MovieSearchResultTableViewCell.self,
            forCellReuseIdentifier: MovieSearchResultTableViewCell.reuseIdentifier
        )
        
        return tableView
    }()
    
    init(viewModel: DefaultSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    private func setupUI() {
        title = "Search"
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.trailingMargin.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private var bindings = [AnyCancellable]()
    private func setupBinding() {
        viewModel.publishedSearchResult.receive(on: DispatchQueue.main).sink { [weak self] _ in
             self?.tableView.reloadData()
            // Here we can add some error handling logic.
        }.store(in: &bindings)
    }
    
    deinit {
        print("Deinit")
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.scheduleSearch(keyword: searchText)
    }
}
 
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieSearchResultTableViewCell.UIConstants.cellSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchResultTableViewCell.reuseIdentifier) as? MovieSearchResultTableViewCell {
            Task {
                cell.viewModel = await viewModel.buildCellViewModel(at: indexPath.row)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.searchResult[indexPath.row]
        self.coordinator?.showDetails(for: movie)
    }
}
