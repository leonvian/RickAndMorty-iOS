//
//  CharacterAPIMock.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 27/01/24.
//

import Foundation


class CharacterAPIMock: CharacterAPIProtocol {
    
    
    func fetchAllCharacters(page: Int, name: String?, status: String?, completion: @escaping (CharacterResponse?, Error?) -> Void) {
        var results =  [Character]()
        results.append(Character(id: 1, name: "Teste 1", image: " Image 1", gender: "Male", species: "Human", status: "alive"))
        results.append(Character(id: 2, name: "Teste 2", image: " Image 2", gender: "Female", species: "Human", status: "alive"))
        results.append(Character(id: 3, name: "Teste 3", image: " Image 3", gender: "Male", species: "Human", status: "alive"))
        let info = Info(count: 3, pages: 1)
        let response = CharacterResponse(info: info, results: results)
        completion(response, nil)
    }

}
