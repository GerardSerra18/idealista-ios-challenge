//
//  Utils.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import UIKit

struct Feature {
    let icon: String
    let text: String
}

// MARK: - Method to extract an icon for the feature
func makeFeatureView(icon: String, text: String) -> UIStackView {
    let iconView = UIImageView(image: UIImage(systemName: icon))
    iconView.tintColor = .systemYellow
    iconView.translatesAutoresizingMaskIntoConstraints = false
    iconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
    iconView.heightAnchor.constraint(equalToConstant: 16).isActive = true

    let label = UILabel()
    label.text = text
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .secondaryLabel

    let stack = UIStackView(arrangedSubviews: [iconView, label])
    stack.axis = .horizontal
    stack.spacing = 4
    return stack
}

// MARK: - Feature from ListView
func extractFeatures(from ad: AdModel) -> [Feature] {
    var result: [Feature] = []

    if ad.features.hasAirConditioning == true {
        result.append(Feature(icon: "wind", text: "A/C"))
    }
    if ad.features.hasBoxRoom == true {
        result.append(Feature(icon: "cube.box", text: "Trastero"))
    }
    if ad.parkingSpace?.hasParkingSpace == true {
        result.append(Feature(icon: "car.fill", text: "Garaje"))
    }

    return result
}

// MARK: - Feature from DetailView
func extractFeatures(from detail: AdDetailModel) -> [Feature] {
    var result: [Feature] = []
    let mc = detail.moreCharacteristics

    if mc.lift == true {
        result.append(Feature(icon: "arrow.up.arrow.down.circle", text: "Ascensor"))
    }
    if mc.boxroom == true {
        result.append(Feature(icon: "cube.box", text: "Trastero"))
    }
    if mc.isDuplex == true {
        result.append(Feature(icon: "square.split.2x1.fill", text: "Dúplex"))
    }
    if let status = mc.status {
        result.append(Feature(icon: "hammer.fill", text: "Estado: \(status.capitalized)"))
    }
    if let community = mc.communityCosts {
        result.append(Feature(icon: "eurosign.circle", text: "Comunidad: \(Int(community)) €"))
    }

    return result
}
