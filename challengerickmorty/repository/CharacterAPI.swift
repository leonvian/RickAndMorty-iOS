//
//  CharacterAPI.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 21/01/24.
//

import Foundation


protocol CharacterAPIProtocol {
    
    func fetchAllCharacters(page: Int,
                            name: String?,
                            status: String?,
                            completion: @escaping (CharacterResponse?, Error?) -> Void)
    
}


class CharacterAPI: CharacterAPIProtocol {
    
    let baseURL = "https://rickandmortyapi.com/api/character/"
    
    func fetchAllCharacters(page: Int,
                            name: String?,
                            status: String?,
                            completion: @escaping (CharacterResponse?, Error?) -> Void) {
           var components = URLComponents(string: baseURL)
           components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
           ]
        
        if name != nil && !name!.isEmpty {
            components?.queryItems?.append(URLQueryItem(name: "name", value: "\(name!)"))
        }
        
        if let status = status {
            components?.queryItems?.append(URLQueryItem(name: "status", value: "\(status)"))
        }
        
           guard let url = components?.url else {
               print("Invalid URL")
               return
           }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching characters: \(error)")
                    completion(nil, error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response from server")
                    completion(nil, error)
                    return
                }

                guard let data = data else {
                    print("No data received")
                    completion(nil, error)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let characterResponse = try decoder.decode(CharacterResponse.self, from: data)
                    completion(characterResponse, nil)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil, error)
                }
            }

            task.resume()
    }
    
}
