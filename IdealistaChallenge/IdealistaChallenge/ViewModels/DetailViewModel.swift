//
//  DetailViewModel.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import Foundation

class DetailViewModel {
    
    private let detail: AdDetailModel
    
    init(detail: AdDetailModel) {
        self.detail = detail
    }

    var titleText: String {
        return "\(detail.propertyType.capitalized) - \(detail.operation.capitalized)"
    }

    var priceText: String {
        return "\(Int(detail.priceInfo.amount)) \(detail.priceInfo.currencySuffix)"
    }

    var descriptionText: String {
        return detail.propertyComment
    }

    var locationText: String {
        return "Lat: \(detail.ubication.latitude), Lon: \(detail.ubication.longitude)"
    }

    var featuresText: String {
        var items: [String] = []
        
        if let roomNumber = detail.moreCharacteristics.roomNumber {
            items.append("🛏 \(roomNumber) habitaciones")
        }
        if let bathNumber = detail.moreCharacteristics.bathNumber {
            items.append("🛁 \(bathNumber) baños")
        }
        if let constructedArea = detail.moreCharacteristics.constructedArea {
            items.append("📐 \(constructedArea) m²")
        }
        if let floor = detail.moreCharacteristics.floor {
            items.append("🏢 Planta \(floor)")
        }
        if let exterior = detail.moreCharacteristics.exterior {
            items.append(exterior ? "🌇 Exterior" : "🏠 Interior")
        }
        return items.joined(separator: " • ")
    }

    var energyLabelText: String {
        return "Energy Certification: \(detail.energyCertification.energyConsumption.type.uppercased())"
    }

    var imageURLs: [URL] {
        return detail.multimedia.images.compactMap { $0.url }
    }
}

