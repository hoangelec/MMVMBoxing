//
//  MovieSearchTableViewCell.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 09/09/2023.
//

import UIKit
import SnapKit

final class MovieSearchResultTableViewCell: UITableViewCell {
    
    enum UIConstants {
        static let cellSize: Double = 100
    }
    
    static let reuseIdentifier = "MovieSearchTableViewCell"
    private lazy var titleLabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var overviewLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    private lazy var posterImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var viewModel: MovieSearchResultViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { make in
            make.leadingMargin.equalToSuperview()
            make.width.equalTo(posterImageView.snp.height)
            make.topMargin.equalToSuperview()
            make.bottomMargin.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(5)
            make.top.equalTo(posterImageView.snp.top)
            make.trailingMargin.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(titleLabel)
            make.bottomMargin.equalToSuperview()
        }
    }
    
    func updateUI() {
        titleLabel.text = viewModel?.title
        overviewLabel.text = viewModel?.overview
        viewModel?.loadImage(completion: { [weak self] in
            self?.posterImageView.image = $0
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
}
