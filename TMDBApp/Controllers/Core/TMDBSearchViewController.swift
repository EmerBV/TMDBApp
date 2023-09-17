//
//  TMDBSearchViewController.swift
//  TMDBApp
//
//  Created by Emerson Balahan Varona on 17/9/23.
//

import UIKit

final class TMDBSearchViewController: UIViewController {
    
    private var titles: [TMDBTitle] = [TMDBTitle]()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TMDBTitleTableViewCell.self, forCellReuseIdentifier: TMDBTitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: TMDBSearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(discoverTable)
        discoverTable.backgroundColor = .black
        discoverTable.delegate = self
        discoverTable.dataSource = self
        navigationItem.searchController = searchController
        fetchDiscoverMovies()
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func fetchDiscoverMovies() {
        TMDBAPICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension TMDBSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TMDBTitleTableViewCell.identifier, for: indexPath) as? TMDBTitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let model = TMDBTitleViewModel(titleName: (title.original_name ?? title.original_title) ?? "Unknown name", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else {
            return
        }
        
        TMDBAPICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TMDBTitlePreviewViewController()
                    vc.configure(with: TMDBTitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "", voteAverage: title.vote_average))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension TMDBSearchViewController: UISearchResultsUpdating, TMDBSearchResultsViewControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? TMDBSearchResultsViewController else {return}
        
        resultsController.delegate = self
        
        TMDBAPICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func tmdbSearchResultsViewControllerDidTapItem(_ viewModel: TMDBTitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TMDBTitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
