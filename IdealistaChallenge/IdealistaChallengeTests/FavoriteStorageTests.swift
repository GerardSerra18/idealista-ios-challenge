//
//  FavoriteStorageTests.swift
//  IdealistaChallengeTests
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import XCTest
@testable import IdealistaChallenge

final class FavoriteStorageTests: XCTestCase {
    
    func testSaveAndRemoveFavorite() {
        let storage = FavoriteStorage()
        let testAdCode = "TEST_AD_CODE"
        let testDate = Date()

        storage.saveFavorite(adCode: testAdCode, date: testDate)
        XCTAssertTrue(storage.isFavorite(adCode: testAdCode), "The ad would be marked as favourite")

        storage.removeFavorite(adCode: testAdCode)
        XCTAssertFalse(storage.isFavorite(adCode: testAdCode), "The ad wouldn't be marked as favourite")
    }
}
