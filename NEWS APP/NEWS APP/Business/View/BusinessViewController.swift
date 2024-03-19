//
//  BusinessViewController.swift
//  NEWS APP
//
//  Created by Vova on 11.03.2024.
//

import UIKit
import SnapKit

class BusinessViewController: UIViewController  {
    // MARK: - Gui Variables
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.frame.width,
                                                            height: view.frame.height),
                                              collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var viewModel: BusinessViewModelProtocol
    
    // MARK: - Life Cycle
    init(viewModel: BusinessViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupUI()
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // MARK: - Private methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] row in
            self?.collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
        }
        
        viewModel.showError = { [weak self] error in
         // TODO: Show alert with error
            print(error)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension BusinessViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell
        }
        
        
        if let cell = cell {
            let article = viewModel.getArticle(for: indexPath.row)
            
            if let generalCell = cell as? GeneralCollectionViewCell {
                generalCell.set(article: article)
            } else if let detailsCell = cell as? DetailsCollectionViewCell {
                detailsCell.set(article: article)
            }
        }
        
        return cell ?? UICollectionViewCell()
    }
}


// MARK: - UICollectionViewDelegate
extension BusinessViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.getArticle(for: indexPath.row)
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension BusinessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let firstSectionSize = CGSize(width: width, height: width)
        
        let secondSectionSize = CGSize(width: width, height: 100)
        
       return indexPath.section == 0 ? firstSectionSize : secondSectionSize
    }
}
