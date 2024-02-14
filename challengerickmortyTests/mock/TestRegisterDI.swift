//
//  TestRegisterDI.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 27/01/24.
//

import Foundation

extension TestRegisterResolver: ResolverRegistering {
    public static func registerAllServices() {
        
        register { CharacterAPI() as CharacterAPIProtocol }
        
        register { CharacterCache() as CharacterCacheProtocol }
        
        register { CharacterRepository() as CharacterRepositoryProtocol }
        
        register { CharactersViewModel() }
        
    }
}
