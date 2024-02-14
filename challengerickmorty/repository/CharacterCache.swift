//
//  CharacterCache.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 21/01/24.
//

import Foundation


protocol CharacterCacheProtocol {
    
    func store(searchCriteria: String, characters: [Character])
    
    func get(searchCriteria: String) -> [Character]
     
    func contains(criteria: String) -> Bool
    
    func clear()
    
}

class CharacterCache: CharacterCacheProtocol {
    
    
    func store(searchCriteria: String, characters: [Character]) {
        DataHolder.shared.cacheSearch[searchCriteria] = characters
    }
    
    func get(searchCriteria: String) -> [Character] {
        if DataHolder.shared.cacheSearch.keys.contains(searchCriteria) {
            return DataHolder.shared.cacheSearch[searchCriteria]!
        } else {
            return []
        }
    }
     
    func contains(criteria: String) -> Bool {
        return DataHolder.shared.cacheSearch.keys.contains(criteria)
    }
    
    func clear() {
        DataHolder.shared.cacheSearch.removeAll()
    }
    
}

private class DataHolder {
     
    var cacheSearch: [String: [Character]] = [:]
    
    static let shared = DataHolder()
    
    private init() { }
    
}
