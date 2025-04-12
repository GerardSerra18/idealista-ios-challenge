//
//  DetailViewModel.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import UIKit

class DetailViewModel {
    
    private let detail: AdDetailModel
    
    init(detail: AdDetailModel) {
        self.detail = detail
    }

    var titleText: String {
        if detail.propertyType == "homes" && detail.operation == "sale" {
            return "Vivienda en venta"
        } else if detail.operation == "rent" {
            return "Vivienda en alquiler"
        } else {
            return "\(detail.propertyType.capitalized) - \(detail.operation.capitalized)"
        }
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
        let mc = detail.moreCharacteristics

        if let roomNumber = mc.roomNumber { items.append("\(roomNumber) habitaciones") }
        if let bathNumber = mc.bathNumber { items.append("\(bathNumber) baños") }
        if let constructedArea = mc.constructedArea { items.append("\(constructedArea) m²") }
        if let floor = mc.floor { items.append("Planta \(floor)") }
        if let exterior = mc.exterior { items.append(exterior ? "Exterior" : "Interior") }
        if let lift = mc.lift, lift { items.append("Ascensor") }
        if let status = mc.status { items.append("Estado: \(status.capitalized)") }
        if let community = mc.communityCosts { items.append("Comunidad: \(Int(community)) €/mes") }

        return items.joined(separator: " • ")
    }

    var energyLabelText: String {
        return "Energy Certification: \(detail.energyCertification.energyConsumption.type.uppercased())"
    }

    var imageURLs: [URL] {
        return detail.multimedia.images.compactMap { $0.url }
    }

    var featureIcons: [UIView] {
        return extractFeatures(from: detail).map {
            makeFeatureView(icon: $0.icon, text: $0.text)
        }
    }
    
    var latitude: Double {
        return detail.ubication.latitude
    }
    
    var longitude: Double {
        return detail.ubication.longitude
    }
}

