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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "🏡 Propiedades disponibles"
        
        setupTableView()
        
        viewModel.fetchAds { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
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
        cell.configure(with: ad)
        
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
