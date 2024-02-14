//
//  CharacterResponse.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 21/01/24.
//

import Foundation

struct CharacterResponse: Decodable {
    
    let info: Info
    let results: [Character]
    
}

struct Info: Decodable {
   let count: Int
   let pages: Int
}
