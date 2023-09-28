//
//  MovieDetailViewController.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 11/09/2023.
//

import Foundation
import UIKit

final class MovieDetailViewController: UIViewController {

    private var viewModel: MovieDetailViewModel
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var overviewLabel = {
        let label = UILabel()
        label.text = viewModel.overview
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 16)
        return label
    }()

    private lazy var releaseDateLabel = {
        let label = UILabel()
        label.text = viewModel.releaseDate
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(releaseDateLabel)

        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.width.equalTo(imageView.snp.height)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().dividedBy(2)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leadingMargin.trailingMargin.equalToSuperview()
        }

        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }

        viewModel.loadImage { [weak self] in
            self?.imageView.image = $0
        }
    }
}
