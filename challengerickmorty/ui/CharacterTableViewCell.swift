//
//  CharacterTableViewCell.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 21/01/24.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    let characterImageView = UIImageView()
    let characterNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        characterImageView.contentMode = .scaleToFill
        contentView.addSubview(characterImageView)

        characterNameLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(characterNameLabel)

        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            characterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 100),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor),
            
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
