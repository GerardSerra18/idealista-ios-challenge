//
//  FavoritesViewController.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import UIKit

class FavoritesViewController: UIViewController {

    private let tableView = UITableView()
    private let viewModel = ListViewModel()
    private var favoriteAds: [AdModel] = []
    private let emptyLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("favorites_title", comment: "")
        view.backgroundColor = .systemBackground
        setupTableView()
        setupEmptyLabel()
        loadFavorites()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AdTableViewCell.self, forCellReuseIdentifier: AdTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
    
    private func setupEmptyLabel() {
        
        emptyLabel.text = NSLocalizedString("empty_favorites_message", comment: "")
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .secondaryLabel
        emptyLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        emptyLabel.isHidden = true
    }

    private func loadFavorites() {
        viewModel.fetchAds { [weak self] in
            guard let self = self else { return }
            let favoriteCodes = FavoriteStorage().getFavorites().keys
            self.favoriteAds = self.viewModel.ads.filter { favoriteCodes.contains($0.propertyCode) }
            self.tableView.reloadData()
            self.emptyLabel.isHidden = !self.favoriteAds.isEmpty
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteAds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as? AdTableViewCell else {
            return UITableViewCell()
        }

        let ad = favoriteAds[indexPath.row]
        let date = FavoriteStorage().favoriteDate(for: ad.propertyCode)
        cell.configure(with: ad, isFavorite: true, favoriteDate: date)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        APIService.shared.fetchAdDetail { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    let detailVM = DetailViewModel(detail: detail)
                    let vc = DetailViewController(viewModel: detailVM)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .failure(let error):
                    print("Error loading detail: \(error)")
                }
            }
        }
    }
}
