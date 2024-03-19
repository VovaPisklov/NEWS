//
//  DetailsCollectionViewCell.swift
//  NEWS APP
//
//  Created by Vova on 12.03.2024.
//

import UIKit
import SnapKit

final class DetailsCollectionViewCell: UICollectionViewCell {
    // MARK: - Gui Variables
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Title here"
        label.numberOfLines = 2
        
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14 )
        label.textColor = .gray
        label.text = "Title here Title her Title her Title her Title her Title her Title her Title her Title her Title her Title her "
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - Initialisations
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    
    // MARK: - Private methods
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.height.equalTo(self.frame.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
}
