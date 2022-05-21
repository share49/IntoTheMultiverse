//
//  CharacterDetailViewController.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import UIKit
import Combine
import Kingfisher

final class CharacterDetailViewController: UIViewController, ActivityPresentable, ErrorPresentable {
    
    // MARK: - Properties
    
    private let viewModel: CharacterDetailViewModel
    private weak var coordinator: MainCoordinator?
    private var subscriptions = Set<AnyCancellable>()
    private let imageView = UIImageView()
    private let btnFavorite = UIButton(type: .custom)
    private let lblDescription = UILabel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let cellIdentifier = Constants.UI.Cells.comicCell
    private let ctMargin = Constants.UI.margin
    private let lblDescriptionNumberOfLines = 0
    
    // MARK: - Initializer
    
    init(with viewModel: CharacterDetailViewModel, coordinator: MainCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
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
        
        Task {
            await viewModel.loadComicCharacter()
        }
    }
    
    // MARK: - Combine bindings
    
    func setupBindings() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updateActivityIndicatorState(isLoading: $0) }
            .store(in: &subscriptions)
        
        viewModel.$comicCharacter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updateUI(with: $0) }
            .store(in: &subscriptions)
        
        viewModel.$alertMessage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] receivedValue in
                if let message = receivedValue {
                    self?.presentOKAlert(errorMessage: message)
                }
            })
            .store(in: &subscriptions)
        
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.setupButtonImage(for: $0) }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupImageView()
        setupButtonFavorite()
        setupEasterEggInteraction()
        setupLabelDescription()
        setupTableView()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    }
    
    private func setupButtonFavorite() {
        imageView.addSubview(btnFavorite)
        btnFavorite.translatesAutoresizingMaskIntoConstraints = false
        
        btnFavorite.topAnchor.constraint(equalTo: imageView.topAnchor, constant: ctMargin).isActive = true
        btnFavorite.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -ctMargin).isActive = true
        
        let btnAction = UIAction { [weak self] _ in
            self?.viewModel.handleFavoritesTap()
        }
        btnFavorite.addAction(btnAction, for: .touchUpInside)
    }
    
    private func setupLabelDescription() {
        view.addSubview(lblDescription)
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        
        lblDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ctMargin).isActive = true
        lblDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ctMargin).isActive = true
        lblDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ctMargin).isActive = true
        
        lblDescription.textAlignment = .justified
        lblDescription.numberOfLines = lblDescriptionNumberOfLines
        lblDescription.font = .preferredFont(forTextStyle: .body)
        lblDescription.adjustsFontForContentSizeCategory = true
        lblDescription.adjustsFontSizeToFitWidth = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: lblDescription.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: Constants.UI.comicsTableViewHeight).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: - Combine methods
    
    private func updateActivityIndicatorState(isLoading: Bool) {
        isLoading ? showActivityIndicator() : hideActivityIndicator()
    }
    
    private func updateUI(with comicCharacter: ComicCharacter?) {
        guard let comicCharacter = comicCharacter else {
            return
        }
        
        title = comicCharacter.name
        imageView.kf.setImage(with: comicCharacter.thumbnail.url(for: .original))
        lblDescription.text = comicCharacter.description
        tableView.reloadData()
    }
    
    private func setupButtonImage(for isFavorite: Bool) {
        let imageName = isFavorite ? "star.fill" : "star"
        let btnImage = UIImage(systemName: imageName)
        btnFavorite.setImage(btnImage, for: .normal)
    }
}

// MARK: - EasterEgg

extension CharacterDetailViewController {
    
    private func setupEasterEggInteraction() {
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showEasterEggView(_:)))
        tapGestureRecognizer.minimumPressDuration = 3
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func showEasterEggView(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else {
            return
        }
        
        coordinator?.easterEgg()
    }
}

// MARK: - UITableViewDataSource

extension CharacterDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comicsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.comicName(for: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CharacterDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
