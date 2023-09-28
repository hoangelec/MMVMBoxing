//
//  SearchSceneBuilder.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 11/09/2023.
//

import UIKit

final class SearchSceneBuilder: AppSceneBuilder {
    func build() -> Coordinator {
        let navigationController = UINavigationController()
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        else {
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.tintColor = .systemBackground
        }
        return DefaultSearchSceneCoordinator(navigationController: navigationController)
    }
}

protocol SearchViewControllerBuilder {
    func build() -> SearchViewController
}

enum DefaultSearchViewControllerBuilder: SearchViewControllerBuilder {
    case common
    func build() -> SearchViewController {
        SearchViewController(viewModel: DefaultSearchViewModel())
    }
}
