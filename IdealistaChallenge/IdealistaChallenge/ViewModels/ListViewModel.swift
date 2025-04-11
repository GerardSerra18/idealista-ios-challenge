//
//  ListViewModel.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 11/4/25.
//

import Foundation

class ListViewModel {
    
    var ads: [AdModel] = []
    
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
}
