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
    private var subscriptions = Set<AnyCancellable>()
    private let imageView = UIImageView()
    private let lblDescription = UILabel()
    
    // MARK: - Initializer
    
    init(with viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        
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
    }
    
    // MARK: - UI methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupImageView()
        setupEasterEggInteraction()
        setupLabelDescription()
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
    
    private func setupLabelDescription() {
        view.addSubview(lblDescription)
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        
        lblDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.UI.margin).isActive = true
        lblDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.UI.margin).isActive = true
        lblDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.UI.margin).isActive = true
        
        lblDescription.textAlignment = .justified
        lblDescription.numberOfLines = 0
        lblDescription.font = .preferredFont(forTextStyle: .body)
        lblDescription.adjustsFontForContentSizeCategory = true
    }
    
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
        
        guard let navigationController = navigationController else {
            NSLog("Unable to get navigationController")
            return
        }
        
        Router(navigationController).navigate(to: .easterEggView)
    }
}
