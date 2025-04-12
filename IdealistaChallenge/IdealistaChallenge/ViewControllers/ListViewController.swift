//
//  ListViewController.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 11/4/25.
//

import UIKit

class ListViewController: UIViewController {
    
    private let viewModel = ListViewModel()
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Propiedades disponibles"
        
        setupNavigationBarStyle()
        setupTableView()
        
        viewModel.fetchAds { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        refreshControl.addTarget(self, action: #selector(simulateLoading), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AdTableViewCell.self, forCellReuseIdentifier: AdTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
    
    private func setupNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemYellow
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func updateFavoriteState(for ad: AdModel, cell: AdTableViewCell) {
        let isFavorite = viewModel.isFavorite(ad: ad)
        let date = viewModel.favoriteDate(for: ad)
        cell.configure(with: ad, isFavorite: isFavorite, favoriteDate: date)
        showFavoriteToast(for: ad, isNowFavorite: isFavorite, date: date)
    }
    
    private func showFavoriteToast(for ad: AdModel, isNowFavorite: Bool, date: Date?) {
        let toastLabel = UILabel()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        
        let message: String
        if isNowFavorite, let date = date {
            message = "Añadido a favoritos el \(formatter.string(from: date))"
        } else {
            message = "Eliminado de favoritos"
        }

        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = .systemYellow
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        toastLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(toastLabel)

        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            toastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            toastLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            toastLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])

        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
    
    @objc private func simulateLoading() {
        loadingIndicator.startAnimating()
        
        //Simulates a network delay of 2 seconds to provide better effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.fetchAds {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.loadingIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfAds()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as? AdTableViewCell,
              let ad = viewModel.ad(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let isFavorite = viewModel.isFavorite(ad: ad)
        let favoriteDate = viewModel.favoriteDate(for: ad)
        cell.configure(with: ad, isFavorite: isFavorite, favoriteDate: favoriteDate)

        cell.onFavoriteTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.toggleFavorite(for: ad)
            self.updateFavoriteState(for: ad, cell: cell)
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.fetchAdDetail { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    let detailVM = DetailViewModel(detail: detail)
                    let detailVC = DetailViewController(viewModel: detailVM)
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                case .failure(let error):
                    print("Error fetching detail: \(error.localizedDescription)")
                }
            }
        }
    }
}
