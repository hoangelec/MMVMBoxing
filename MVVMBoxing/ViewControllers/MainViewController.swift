//
//  ViewController.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//

import UIKit
import SnapKit
import Combine

class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    
    private lazy var searchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var statusLabel = UILabel()
    
    private lazy var imageView = UIImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
    }
    
    private func setupUI() {
        title = "Poke search"
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        view.addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leadingMargin.trailingMargin.equalToSuperview()
        }
    }
    
    private var bindings = [AnyCancellable]()
    private func setupBinding() {
         let searchResultBinding = viewModel.$searchResult.sink {
            print("search result: \($0)")
        }
        
        bindings.append(searchResultBinding)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
 
