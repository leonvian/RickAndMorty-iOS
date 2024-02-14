//
//  CharacterDetailsViewController.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 25/01/24.
//

import Foundation
import UIKit


class CharacterDetailsViewController: UIViewController {
    
    var character: Character?

    let characterImageView = UIImageView()
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let genderLabel = UILabel()
    let speciesLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        configureUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        view.addSubview(characterImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        view.addSubview(nameLabel)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(statusLabel)

        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(genderLabel)

        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(speciesLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 200),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            genderLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            speciesLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            speciesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
    }

    private func configureUI() {
        if let character = character {
            
            if let imageUrl = URL(string: character.image) {
                loadImage(from: imageUrl) { image in
                    DispatchQueue.main.async {
                        self.characterImageView.image = image
                    }
                }
            }
            
            nameLabel.text = character.name
            statusLabel.text = "Status: \(character.status)"
            genderLabel.text = "Gender: \(character.gender)"
            speciesLabel.text = "Species: \(character.species)"
        }
    }
    
    
}
