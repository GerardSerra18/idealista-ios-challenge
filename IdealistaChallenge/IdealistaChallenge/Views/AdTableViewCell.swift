//
//  AdTableViewCell.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 11/4/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    static let identifier = "AdTableViewCell"
    
    var onFavoriteTapped: (() -> Void)?

    var images: [URL] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.secondarySystemBackground : .systemBackground
        }
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()

    private let operationTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let surfaceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 12
        collectionView.clipsToBounds = true
        return collectionView
    }()

    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let featureStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = .label
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(container)
        container.addSubview(collectionView)
        container.addSubview(favoriteButton)
        container.addSubview(operationTypeLabel)
        container.addSubview(headerStack)
        container.addSubview(surfaceLabel)
        container.addSubview(detailsLabel)
        container.addSubview(locationLabel)
        container.addSubview(featureStackView)
        collectionView.addSubview(badgeLabel)

        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(priceLabel)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            collectionView.topAnchor.constraint(equalTo: container.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 220),

            favoriteButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            favoriteButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            operationTypeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            operationTypeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            operationTypeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            headerStack.topAnchor.constraint(equalTo: operationTypeLabel.bottomAnchor, constant: 4),
            headerStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            headerStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            surfaceLabel.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 4),
            surfaceLabel.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            surfaceLabel.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),

            detailsLabel.topAnchor.constraint(equalTo: surfaceLabel.bottomAnchor, constant: 4),
            detailsLabel.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
                
            featureStackView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            featureStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            featureStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            featureStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
        ])
        
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }

    func configure(with ad: AdModel, isFavorite: Bool, favoriteDate: Date? = nil) {
        operationTypeLabel.text = "\(ad.operation.capitalized) - \(ad.propertyType.capitalized)"
        titleLabel.text = "Piso en \(ad.address)"
        priceLabel.text = formattedPrice(ad: ad)
        surfaceLabel.text = "\(Int(ad.size)) m² - \(ad.exterior ? "Exterior" : "Interior")"
        detailsLabel.text = "Rooms: \(ad.rooms) | Bathrooms: \(ad.bathrooms)\nFloor: \(ad.floor)"
        images = ad.multimedia.images.compactMap { $0.url }
        
        let iconName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: iconName), for: .normal)
        
        let neighborhood = ad.neighborhood ?? ""
        locationLabel.text = " Ubicado en \(neighborhood), \(ad.district)"

        //features
        featureStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let features = extractFeatures(from: ad)
        features.forEach {
            featureStackView.addArrangedSubview(makeFeatureView(icon: $0.icon, text: $0.text))
        }
    }

    private func formattedPrice(ad: AdModel) -> String {
        let amount = Int(ad.price)
        let suffix = ad.priceInfo.price.currencySuffix
        return "\(amount) \(suffix)"
    }
    
    @objc private func favoriteTapped() {
        onFavoriteTapped?()
    }
}

extension AdTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let url = images[indexPath.item]
        cell.setImage(url: url)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.bounds.height)
    }
}

