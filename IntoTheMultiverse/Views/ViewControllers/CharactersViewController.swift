//
//  CharactersViewController.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/5/22.
//

import UIKit
import Combine
import Kingfisher

final class CharactersViewController: UIViewController, ActivityPresentable, ErrorPresentable {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let cellIdentifier = Constants.UI.Cells.characterCell
    private let persistenceManager: PersistenceHandler
    private let viewModel: CharactersViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initializer
    
    init(with viewModel: CharactersViewModel, persistenceManager: PersistenceHandler) {
        self.viewModel = viewModel
        self.persistenceManager = persistenceManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        deselectTableViewRow()
        
        Task {
            await viewModel.loadFirstComicCharacters()
        }
    }
    
    // MARK: - Combine bindings
    
    /// Setup combine bindings for the viewModel
    func setupBindings() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updateActivityIndicatorState(isLoading: $0) }
            .store(in: &subscriptions)
        
        viewModel.$comicCharacters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &subscriptions)
        
        viewModel.$alertMessage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] receivedValue in
                if let message = receivedValue {
                    self?.presentOKAlert(errorMessage: message)
                }
            })
            .store(in: &subscriptions)
    }
    
    // MARK: - UI methods
    
    /// Setup View and TableView
    private func setupUI() {
        title = Constants.ViewsText.titleCharactersVC
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func updateActivityIndicatorState(isLoading: Bool) {
        isLoading ? showActivityIndicator() : hideActivityIndicator()
    }
    
    private func deselectTableViewRow() {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else {
            return
        }
        
        tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
    }
    
    // MARK: - Router methods
    
    /// Navigates to CharacterDetailViewController
    private func showCharacterDetailView(for characterId: Int) {
        guard let navigationController = navigationController else {
            NSLog("Unable to get navigationController")
            return
        }
        
        let viewModel = CharacterDetailViewModel(characterId: characterId, persistenceManager: persistenceManager)
        Router(navigationController).navigate(to: .characterDetail(viewModel: viewModel))
    }
}

// MARK: - UITableViewDataSource

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comicCharacters.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        Task {
            await viewModel.loadMoreComicCharactersIfNeeded(for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CharacterListCell else {
            fatalError("Couldn't cast cell as CharacterListCell")
        }
        
        let comicCharacter = viewModel.getCharacter(for: indexPath)
        cell.setup(with: CharacterListCellViewModel(with: comicCharacter))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterId = viewModel.getCharacterId(for: indexPath)
        showCharacterDetailView(for: characterId)
    }
}
