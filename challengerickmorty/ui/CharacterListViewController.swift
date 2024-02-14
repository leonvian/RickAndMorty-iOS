//
//  ViewController.swift
//  challengerickmorty
//
//  Created by Leonardo Casasanta on 20/01/24.
//

import UIKit
import Resolver

class CharacterListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel = Resolver.resolve(CharactersViewModel.self)
    
    private var characters: [Character] = []
    private var isLoadingMore = false
    
    private let tableViewCharacters: UITableView = UITableView(frame: .zero)
    
    private let titleLabel = UILabel()
    private let errorLabel = UILabel()
    private let searchButton = UIButton()
    private let retryButton = UIButton()
    private let nameTextField = UITextField()
    private let statusAliveButton = UIButton()
    private let statusDeadButton = UIButton()
    private let statusUnknownButton = UIButton()
    private let applyButton = UIButton()
    private var tableViewTopConstraint: NSLayoutConstraint!
    
    private var isSearchExpanded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        
        setupErrorLabel()
        
        setupRetryButton()
        
        setupSearchButton()
        
        setupSearchLayout()
        
        setUpTableViewCharacters()
        
        setUpConstraints()
        
        toggleSearchView()
        
        loadMoreCharacters()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Rick and Morty"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        
        view.addSubview(titleLabel)
    }
    
    private func setupErrorLabel() {
        errorLabel.text = "Unexpected Error"
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = UIFont.systemFont(ofSize: 22)
        
        view.addSubview(errorLabel)
    }
    
    private func setupSearchButton() {
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(toggleSearchView), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.backgroundColor = .black
        
        view.addSubview(searchButton)
    }
    
    private func setupRetryButton() {
        retryButton.setTitle("Retry", for: .normal)
        retryButton.addTarget(self, action: #selector(retryButtonAction), for: .touchUpInside)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.backgroundColor = .black
        
        view.addSubview(retryButton)
    }
    
    @objc private func toggleSearchView() {
        isSearchExpanded = !isSearchExpanded
        toggleSearchLayout(isExpanded: isSearchExpanded)
    }
    
    @objc private func retryButtonAction() {
       loadMoreCharacters()
    }
    
    private func setUpTableViewCharacters() {
        tableViewCharacters.register(CharacterTableViewCell.self, forCellReuseIdentifier: "characterCell")
        tableViewCharacters.rowHeight = 116
        tableViewCharacters.translatesAutoresizingMaskIntoConstraints = false
        tableViewCharacters.dataSource = self
        tableViewCharacters.delegate = self
        view.addSubview(tableViewCharacters)
    }
    
    private func setupSearchLayout() {
        nameTextField.placeholder = "Enter name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameTextField)
        
        applyButton.setTitle("Apply", for: .normal)
        applyButton.addTarget(self, action: #selector(applySearch), for: .touchUpInside)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.backgroundColor = .black
        
        view.addSubview(applyButton)
    }
    
    @objc private func applySearch() {
        isSearchExpanded = false
        
        guard let nameSearch = nameTextField.text else { return }
            
        characters.removeAll()
        viewModel.changeSearchCriteria(nameSearch: nameSearch, status: "")
        loadMoreCharacters()
        
        nameTextField.text = ""
        toggleSearchLayout(isExpanded: isSearchExpanded)
    }
    
    private func setUpConstraints() {
        tableViewTopConstraint = tableViewCharacters.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchButton.widthAnchor.constraint(equalToConstant: 80),
            searchButton.heightAnchor.constraint(equalToConstant: 45),
            
            nameTextField.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            applyButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            applyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            applyButton.widthAnchor.constraint(equalToConstant: 80),
            applyButton.heightAnchor.constraint(equalToConstant: 45),
            
            tableViewTopConstraint,
            tableViewCharacters.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableViewCharacters.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableViewCharacters.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.heightAnchor.constraint(equalToConstant: 45),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor),
            retryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            retryButton.widthAnchor.constraint(equalToConstant: 80),
            retryButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
   

    private func toggleSearchLayout(isExpanded: Bool) {
        nameTextField.isHidden = !isExpanded
        statusAliveButton.isHidden = !isExpanded
        statusDeadButton.isHidden = !isExpanded
        statusUnknownButton.isHidden = !isExpanded
        applyButton.isHidden = !isExpanded
        
        print(applyButton.frame.size.height)
        
        tableViewTopConstraint.constant = isExpanded ? 24 + nameTextField.frame.size.height + applyButton.frame.size.height : 10

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func loadMoreCharacters() {
        isLoadingMore = true
        viewModel.loadNextPage(onSuccess: { [weak self] newCharacters in
            DispatchQueue.main.async {
                self?.characters += newCharacters
                self?.tableViewCharacters.reloadData()
                self?.isLoadingMore = false
            }
        }, onError: { [weak self] error in
            self?.tableViewCharacters.isHidden = true
            print(error)
            self?.isLoadingMore = false
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        cell.characterNameLabel.text = character.name
        
        if let imageUrl = URL(string: character.image) {
            loadImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    if tableView.cellForRow(at: indexPath) == cell {
                        cell.characterImageView.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showCharacterDetails(for: characters[indexPath.row])
    }
    
    func showCharacterDetails(for character: Character) {
        let detailsVC = CharacterDetailsViewController()
        detailsVC.character = character
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
        if indexPath.row == lastRowIndex && !isLoadingMore {
            loadMoreCharacters()
        }
    }
    
    
}
