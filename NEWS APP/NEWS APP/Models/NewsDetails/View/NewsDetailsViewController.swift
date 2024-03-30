//
//  NewsDetailsViewController.swift
//  NEWS APP
//
//  Created by Vova on 11.03.2024.
//

import UIKit

final class NewsDetailsViewController: UIViewController {
    
    // MARK: - Gui Variables
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    
    // MARK: - Properties
    private var edgeInset = 10
    private var viewModel: NewsDetailsViewModelProtocol

    // MARK: - Life Cycle
    init(viewModel: NewsDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupUI()
    }
    // MARK: - Methods
    
    // MARK: - Private methods
    private func setupUI() {
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        view.addSubview(scrollView)

        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        if let data = viewModel.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView.image = UIImage(systemName: "photo")
            imageView.contentMode = .scaleAspectFit
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.bottom.equalToSuperview().inset(edgeInset)
        }
    }
}
