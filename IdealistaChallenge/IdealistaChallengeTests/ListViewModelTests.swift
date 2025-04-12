//
//  ListViewModelTests.swift
//  IdealistaChallengeTests
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import XCTest
@testable import IdealistaChallenge

final class ListViewModelTests: XCTestCase {
    
    func testToggleFavoriteAddsAndRemoves() {
        let ad = AdModel(propertyCode: "TEST_CODE", thumbnail: nil, floor: "", price: 1000, priceInfo: PriceInfo(price: Price(amount: 1000, currencySuffix: "€")), propertyType: "home", operation: "sale", size: 100, exterior: true, rooms: 2, bathrooms: 1, address: "TEST ADDRESS", province: "TEST PROVINCE", municipality: "TEST MUNICIPALITY", district: "TEST DISTRICT", country: "TEST COUNTRY", neighborhood: nil, latitude: 0, longitude: 0, description: "", multimedia: Multimedia(images: []), features: Features(hasAirConditioning: false, hasBoxRoom: false), parkingSpace: nil)
        
        let viewModel = ListViewModel()
        viewModel.toggleFavorite(for: ad)
        XCTAssert(viewModel.isFavorite(ad: ad), "The ad would be marked as favourite")
        
        viewModel.toggleFavorite(for: ad)
        XCTAssertFalse(viewModel.isFavorite(ad: ad), "The ad wouldn't be marked as favourite")
    }
}
