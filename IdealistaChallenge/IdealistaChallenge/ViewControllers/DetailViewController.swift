//
//  DetailViewController.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    private let scrollView = UIScrollView()
    private let stack = UIStackView()
    private var isExpanded = false
    private let seeMoreButton = UIButton(type: .system)
    
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let featureIconsStack = UIStackView()
    private let featuresLabel = UILabel()
    private let energyLabel = UILabel()
    private let descriptionLabel = UILabel()

    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Detalle del inmueble"
        setupUI()
        configureView()
    }

    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        [titleLabel, priceLabel, featureIconsStack, featuresLabel, energyLabel, descriptionLabel, seeMoreButton].forEach {
            stack.addArrangedSubview($0)
        }

        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        priceLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        featuresLabel.font = .systemFont(ofSize: 14)
        featuresLabel.textColor = .secondaryLabel
        featuresLabel.numberOfLines = 0
        energyLabel.font = .systemFont(ofSize: 14, weight: .medium)
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified
        seeMoreButton.setTitle("Ver más", for: .normal)
        seeMoreButton.addTarget(self, action: #selector(toggleDescription), for: .touchUpInside)
        seeMoreButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        seeMoreButton.contentHorizontalAlignment = .center
        
        //MapView for the location
        let mapView = AdMapView(latitude: viewModel.latitude, longitude: viewModel.longitude)
        let mapHostingController = UIHostingController(rootView: mapView)
        addChild(mapHostingController)
        if let descriptionIndex = stack.arrangedSubviews.firstIndex(of: descriptionLabel) {
            stack.insertArrangedSubview(mapHostingController.view, at: descriptionIndex)
            let spacer = UIView()
            spacer.translatesAutoresizingMaskIntoConstraints = false
            spacer.heightAnchor.constraint(equalToConstant: 2).isActive = true
            stack.insertArrangedSubview(spacer, at: descriptionIndex + 1)
        }
        mapHostingController.didMove(toParent: self)
        mapHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        mapHostingController.view.heightAnchor.constraint(equalToConstant: 200).isActive = true

        featureIconsStack.axis = .horizontal
        featureIconsStack.spacing = 12
        featureIconsStack.distribution = .fillProportionally

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")

        view.addSubview(scrollView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(stack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stack.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func configureView() {
        titleLabel.text = viewModel.titleText
        priceLabel.text = viewModel.priceText
        featuresLabel.text = viewModel.featuresText
        energyLabel.text = viewModel.energyLabelText
        descriptionLabel.text = viewModel.descriptionText
        descriptionLabel.numberOfLines = 10
        seeMoreButton.setTitle("Ver más", for: .normal)

        featureIconsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for feature in viewModel.featureIcons {
            featureIconsStack.addArrangedSubview(feature)
        }
    }
    
    @objc private func toggleDescription() {
        isExpanded.toggle()
        descriptionLabel.numberOfLines = isExpanded ? 0 : 4
        seeMoreButton.setTitle(isExpanded ? "Ver menos" : "Ver más", for: .normal)
    }

}

// MARK: - CollectionView for images
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let url = viewModel.imageURLs[indexPath.item]
        cell.setImage(url: url)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
