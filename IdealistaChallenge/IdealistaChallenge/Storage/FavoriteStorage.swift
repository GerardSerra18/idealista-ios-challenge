//
//  FavoriteStorage.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 12/4/25.
//

import Foundation

class FavoriteStorage {
    
    private let favoritesKey = "favoriteAds"
    
    func saveFavorite(adCode: String, date: Date) {
        var favorites = getFavorites()
        favorites[adCode] = date
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
    
    func removeFavorite(adCode: String) {
        var favorites = getFavorites()
        favorites.removeValue(forKey: adCode)
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
    
    func getFavorites() -> [String:Date] {
        if let data = UserDefaults.standard.data(forKey: favoritesKey), let favorites = try? JSONDecoder().decode([String:Date].self, from: data) {
            return favorites
        }
        return [:]
    }
    
    func isFavorite(adCode: String) -> Bool {
        return getFavorites()[adCode] != nil
    }
    
    func favoriteDate(for adCode: String) -> Date? {
        return getFavorites()[adCode]
    }
}
