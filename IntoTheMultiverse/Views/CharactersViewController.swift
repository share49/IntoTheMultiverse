//
//  CharactersViewController.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/5/22.
//

import UIKit
import Combine

final class CharactersViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private var viewModel: CharactersViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initializer
    
    init(with viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            await viewModel.loadComicCharacters()
        }
    }
    
    // MARK: - Combine bindings
    
    func setupBindings() {
        viewModel.$comicCharacters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI methods
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: k.UI.Cells.characterCell)
    }
    
    // MARK: - Router methods
    
    private func showCharacterDetailView(for characterId: Int) {
        guard let navigationController = navigationController else {
            NSLog("Unable to get navigationController")
            return
        }
        
        Router(navigationController).navigate(to: .characterDetail(characterId: characterId))
    }
}

// MARK: - UITableViewDataSource

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comicCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: k.UI.Cells.characterCell, for: indexPath)
        cell.textLabel?.text = viewModel.comicCharacters[indexPath.row].name
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterId = viewModel.comicCharacters[indexPath.row].id
        showCharacterDetailView(for: characterId)
    }
}
