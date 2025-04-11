//
//  AdModel.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 11/4/25.
//

import Foundation

struct AdModel: Decodable {
    
    let propertyCode: String
    let thumbnail: URL?
    let floor: String
    let price: Double
    let priceInfo: PriceInfo
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String?
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: Multimedia
    let features: Features
    let parkingSpace: ParkingSpace?
}

struct PriceInfo: Decodable {
    let price: Price
}

struct Price: Decodable {
    let amount: Double
    let currencySuffix: String
}

struct Multimedia: Decodable {
    let images: [AdImage]
}

struct AdImage: Decodable {
    let url: URL?
    let tag: String
}

struct Features: Decodable {
    let hasAirConditioning: Bool?
    let hasBoxRoom: Bool?
}

struct ParkingSpace: Decodable {
    let hasParkingSpace: Bool?
    let isParkingSpaceIncludedInPrice: Bool?
    let hasSwimmingPool: Bool?
    let hasTerrace: Bool?
    let hasGarden: Bool?
}
