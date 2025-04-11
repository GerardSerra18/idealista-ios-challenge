//
//  AdTableViewCell.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 11/4/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    static let identifier = "AdTableViewCell"

    var images: [URL] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

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
        return collectionView
    }()

    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(collectionView)
        contentView.addSubview(operationTypeLabel)
        contentView.addSubview(headerStack)
        contentView.addSubview(surfaceLabel)
        contentView.addSubview(detailsLabel)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(priceLabel)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 320),

            operationTypeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            operationTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            operationTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            headerStack.topAnchor.constraint(equalTo: operationTypeLabel.bottomAnchor, constant: 4),
            headerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            headerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            surfaceLabel.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 4),
            surfaceLabel.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            surfaceLabel.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),

            detailsLabel.topAnchor.constraint(equalTo: surfaceLabel.bottomAnchor, constant: 4),
            detailsLabel.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }

    func configure(with ad: AdModel) {
        operationTypeLabel.text = "\(ad.operation.capitalized) - \(ad.propertyType.capitalized)"
        titleLabel.text = "Piso en \(ad.address)"
        priceLabel.text = formattedPrice(ad: ad)
        surfaceLabel.text = "\(Int(ad.size)) m² - \(ad.exterior ? "Exterior" : "Interior")"
        detailsLabel.text = "Rooms: \(ad.rooms) | Bathrooms: \(ad.bathrooms)\nFloor: \(ad.floor)"
        images = ad.multimedia.images.compactMap { $0.url }
    }

    private func formattedPrice(ad: AdModel) -> String {
        let amount = Int(ad.price)
        let suffix = ad.priceInfo.price.currencySuffix
        return "\(amount) \(suffix)"
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

