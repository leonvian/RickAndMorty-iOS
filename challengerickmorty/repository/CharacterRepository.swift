//
//  File.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 21/01/24.
//

import Foundation
import Resolver

protocol CharacterRepositoryProtocol {
    
    func fetchAllCharacters(page: Int,
                            name: String?,
                            status: String?,
                            completion: @escaping ([Character], Error?) -> Void)
     
    
}

class CharacterRepository: CharacterRepositoryProtocol {
    
    @Injected var api: CharacterAPIProtocol
    @Injected var cache: CharacterCacheProtocol
    
    init () {
        
    }
    
    init(api: CharacterAPIProtocol, cache: CharacterCacheProtocol) {
        self.api = api
        self.cache = cache
    }
     
    func fetchAllCharacters(page: Int,
                            name: String?,
                            status: String?,
                            completion: @escaping ([Character], Error?) -> Void) {
        let cacheKey = "\(page) \(name ?? "") \(status ?? "")"
        if cache.contains(criteria: cacheKey) {
            let characters = cache.get(searchCriteria: cacheKey)
            completion(characters, nil)
        } else {
            api.fetchAllCharacters(page: page, name: name, status: status) { characterResponse, error in
                if let error = error {
                    print("Error fetching characters: \(error)")
                    completion([], error)
                } else if let characterResponse = characterResponse {
                    self.cache.store(searchCriteria: cacheKey, characters: characterResponse.results)
                    completion(characterResponse.results, nil)
                }
            }
        }
    }

}

