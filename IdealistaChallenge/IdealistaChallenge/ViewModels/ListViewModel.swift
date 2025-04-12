//
//  ListViewModel.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 11/4/25.
//

import Foundation

class ListViewModel {
    
    var ads: [AdModel] = []
    private var favoriteAds: [String: Date] = [:]
    
    func fetchAds(completion: @escaping () -> Void) {
        APIService.shared.fetchAds { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let fetchedAds):
                    self?.setAds(fetchedAds)
                    completion()
                case .failure(let error):
                    print("Error fetching ads: \(error.localizedDescription)")
                    completion()
                }
            }
        }
    }
    
    /// I know that this API always returns the same detail and does not support filtering by propertyCode,
    /// but I tried to make my best and I did the logic structured in a way that I could extend it to fetch for a specific detail in a real scenario !
    func fetchAdDetail(completion: @escaping (Result<AdDetailModel, Error>) -> Void) {
        APIService.shared.fetchAdDetail { result in
            switch result {
            case .success(let adDetails):
                completion(.success(adDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setAds(_ newAds: [AdModel]) {
        self.ads = newAds
    }
    
    func numberOfAds() -> Int {
        return ads.count
    }
    
    func ad(at index: Int) -> AdModel? {
        if index < ads.count {
            return ads[index]
        } else {
            return nil
        }
    }
    
    func toggleFavorite(for ad: AdModel) {
        if let _ = favoriteAds[ad.propertyCode] {
            favoriteAds.removeValue(forKey: ad.propertyCode)
        } else {
            favoriteAds[ad.propertyCode] = Date()
        }
    }
    
    func isFavorite(ad: AdModel) -> Bool {
        return favoriteAds[ad.propertyCode] != nil
    }
    
    func favoriteDate(for ad: AdModel) -> Date? {
        return favoriteAds[ad.propertyCode]
    }
}
