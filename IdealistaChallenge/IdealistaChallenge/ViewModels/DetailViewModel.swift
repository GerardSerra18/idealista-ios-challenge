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
            return NSLocalizedString("housing_for_sale", comment: "")
        } else if detail.operation == "rent" {
            return  NSLocalizedString("housing_for_rent", comment: "")
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

    var featuresText: String {
        var items: [String] = []
        let mc = detail.moreCharacteristics

        if let roomNumber = mc.roomNumber { items.append(String(format: NSLocalizedString("rooms_format", comment: ""), roomNumber)) }
        if let bathNumber = mc.bathNumber { items.append(String(format: NSLocalizedString("bathrooms_format", comment: ""), bathNumber)) }
        if let constructedArea = mc.constructedArea { items.append("\(constructedArea) m²") }
        if let floor = mc.floor { items.append(String(format: NSLocalizedString("floor_format", comment: ""), floor)) }
        if let exterior = mc.exterior {
            let exteriorText = NSLocalizedString(exterior ? "exterior" : "interior", comment: "")
            items.append(exteriorText)
        }
        if let lift = mc.lift, lift { items.append(NSLocalizedString("lift", comment: "")) }
        if let status = mc.status { items.append(String(format: NSLocalizedString("status_format", comment: ""), status.capitalized)) }
        if let community = mc.communityCosts { items.append(String(format: NSLocalizedString("community_cost_format", comment: ""), Int(community))) }

        return items.joined(separator: " • ")
    }

    var energyLabelText: String {
        return String(format: NSLocalizedString("energy_certification", comment: ""), detail.energyCertification.energyConsumption.type.uppercased())
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

