//
//  NewsViewController.swift
//  NEWS APP
//
//  Created by Vova on 11.03.2024.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Gui Variables
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Image")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Some title for the news"
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac urna id est facilisis commodo. Quisque venenatis, ligula a tincidunt malesuada, augue tortor luctus elit, eu mattis odio nisi eu est. Vestibulum id quam sed libero euismod auctor. Fusce laoreet purus in urna congue, vitae semper sapien tincidunt. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus id tincidunt purus. Ut dapibus, leo in gravida scelerisque, sem risus tincidunt tortor, eu vestibulum lacus neque a odio. Maecenas a orci sit amet dui rhoncus eleifend a sit amet nisi. Nullam in arcu nec elit dignissim efficitur. Sed ac tristique libero. Sed at lacus efficitur, facilisis quam nec, cursus nunc.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac urna id est facilisis commodo. Quisque venenatis, ligula a tincidunt malesuada, augue tortor luctus elit, eu mattis odio nisi eu est. Vestibulum id quam sed libero euismod auctor. Fusce laoreet purus in urna congue, vitae semper sapien tincidunt. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus id tincidunt purus. Ut dapibus, leo in gravida scelerisque, sem risus tincidunt tortor, eu vestibulum lacus neque a odio. Maecenas a orci sit amet dui rhoncus eleifend a sit amet nisi. Nullam in arcu nec elit dignissim efficitur. Sed ac tristique libero. Sed at lacus efficitur, facilisis quam nec, cursus nunc."
        
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .darkGray
        
        return label
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        
        label.text = "12.08.2001"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    
    // MARK: - Properties
    private var edgeInset = 10
    
    // MARK: - Life Cycle
    
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
        contentView.addSubview(dataLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        view.addSubview(scrollView)

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
        
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dataLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.bottom.equalToSuperview().inset(edgeInset)
        }
    }
}
