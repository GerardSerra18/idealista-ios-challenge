//
//  AdDetailModel.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 11/4/25.
//

import Foundation

struct AdDetail: Decodable {
    let adid: Int
    let price: Double
    let priceInfo: DetailPriceInfo
    let operation: String
    let propertyType: String
    let extendedPropertyType: String?
    let homeType: String?
    let state: String
    let multimedia: DetailMultimedia
    let propertyComment: String
    let ubication: Ubication
    let country: String
    let moreCharacteristics: MoreCharacteristics
    let energyCertification: EnergyCertification
}

struct DetailPriceInfo: Decodable {
    let amount: Double
    let currencySuffix: String
}

struct DetailMultimedia: Decodable {
    let images: [DetailAdImage]
}

struct DetailAdImage: Decodable {
    let url: URL?
    let tag: String
    let localizedName: String?
    let multimediaId: Int
}

struct Ubication: Decodable {
    let latitude: Double
    let longitude: Double
}

struct MoreCharacteristics: Decodable {
    let communityCosts: Double?
    let roomNumber: Int?
    let bathNumber: Int?
    let exterior: Bool?
    let housingFurnitures: String?
    let agencyIsABank: Bool?
    let energyCertificationType: String?
    let flatLocation: String?
    let modificationDate: Int64?
    let constructedArea: Int?
    let lift: Bool?
    let boxroom: Bool?
    let isDuplex: Bool?
    let floor: String?
    let status: String?
}

struct EnergyCertification: Decodable {
    let title: String?
    let energyConsumption: EnergyValue
    let emissions: EnergyValue
}

struct EnergyValue: Decodable {
    let type: String
}
