//
//  challengerickmortyTests.swift
//  challengerickmortyTests
//
//  Created by Leonardo Casasanta on 20/01/24.
//

import XCTest
import Resolver

@testable import challengerickmorty

final class challengerickmortyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TestRegistrations.registerTestServices()
    }
     
    
    func testViewModel() throws {
        let viewModel  = CharactersViewModel()
        viewModel.loadNextPage(onSuccess: { characters in
            XCTAssertTrue(characters.count == 3)
        }, onError: { error in
            
        })
    }
    
    
}
