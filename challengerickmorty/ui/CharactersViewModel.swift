//
//  CharactersViewModel.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 22/01/24.
//

import Foundation
import Resolver


class CharactersViewModel {
    
    @Injected  var repository: CharacterRepositoryProtocol
    private var page = 1
    private var nameSearch: String?
    private var status: String?
    
    func changeSearchCriteria(nameSearch: String, status: String) {
        if  nameSearch != self.nameSearch {
            self.page = 1
            self.nameSearch = nameSearch
        }
    }
    
    func loadNextPage(onSuccess: @escaping ([Character]) -> Void,  onError: @escaping(Error) -> Void) {
        repository.fetchAllCharacters(page: page, name: nameSearch, status: status)  { characters, error in
            if let error = error {
                onError(error)
            } else {
                self.page += 1
                onSuccess(characters)
            }
        } 
    }
    
}
