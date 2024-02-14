//
//  Character.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 21/01/24.
//

import Foundation
 
struct Character: Decodable {
    
    let id: Int
    let name: String
    let image: String
    let gender: String
    let species: String
    let status: String
    
}
