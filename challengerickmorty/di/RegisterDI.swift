//
//  RegisterDI.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 22/01/24.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        
        register { CharacterAPI() as CharacterAPIProtocol }
        
        register { CharacterCache() as CharacterCacheProtocol }
        
        register { CharacterRepository() as CharacterRepositoryProtocol }
        
        register { CharactersViewModel() }
        
    }
    
}
