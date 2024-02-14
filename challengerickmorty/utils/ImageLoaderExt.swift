//
//  ImageLoaderExt.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 26/01/24.
//

import Foundation
import UIKit


extension UIViewController {

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
}
