//
//  APIService.swift
//  IdealistaChallenge
//
//  Created by Gerard Serra Rodriguez on 11/4/25.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    private init() {}
    
    private let listURL = URL(string: "https://idealista.github.io/ios-challenge/list.json")!
    private let detailURL = URL(string: "https://idealista.github.io/ios-challenge/detail.json")!
    
    
    //MARK: - Ads call
    func fetchAds(completion: @escaping(Result<[AdModel], Error>) -> Void ) {
        let task = URLSession.shared.dataTask(with: listURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let err = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Any data received"])
                completion(.failure(err))
                return
            }
            
            do {
                let ads = try JSONDecoder().decode([AdModel].self, from: data)
                completion(.success(ads))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
