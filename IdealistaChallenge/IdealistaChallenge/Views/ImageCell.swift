//
//  ImageCell.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = img
                }
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(systemName: "photo")
                }
            }
        }
    }
}

