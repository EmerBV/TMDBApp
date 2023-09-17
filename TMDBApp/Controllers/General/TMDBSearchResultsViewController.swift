//
//  TMDBSearchResultsViewController.swift
//  TMDBApp
//
//  Created by Emerson Balahan Varona on 17/9/23.
//

import UIKit

protocol TMDBSearchResultsViewControllerDelegate: AnyObject {
    func tmdbSearchResultsViewControllerDidTapItem(_ viewModel: TMDBTitlePreviewViewModel)
}

final class TMDBSearchResultsViewController: UIViewController {
    
    public var titles: [TMDBTitle] = [TMDBTitle]()
    
    public weak var delegate: TMDBSearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TMDBTitleCollectionViewCell.self, forCellWithReuseIdentifier: TMDBTitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
}

extension TMDBSearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBTitleCollectionViewCell.identifier, for: indexPath) as? TMDBTitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        
        TMDBAPICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.tmdbSearchResultsViewControllerDidTapItem(TMDBTitlePreviewViewModel(title: title.original_title ?? "", youtubeView: videoElement, titleOverview: title.overview ?? "", voteAverage: title.vote_average))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
