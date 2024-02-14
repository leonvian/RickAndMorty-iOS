//
//  ResolverTests.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 27/01/24.
//

import Foundation
import Resolver


struct TestRegistrations {
    static func registerTestServices() {
        Resolver.register { CharacterAPIMock() as CharacterAPIProtocol }
                   .scope(.application)
                    
    }
}
