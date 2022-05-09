//
//  CharacterDetailViewController.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import UIKit
import Combine

final class CharacterDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: CharacterDetailViewModel
    private var subscriptions = Set<AnyCancellable>()
    
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
        viewModel.$comicCharacter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] comicCharacter in
                guard let comicCharacter = comicCharacter else {
                    return
                }
                self?.updateUI(with: comicCharacter)
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func updateUI(with comicCharacter: ComicCharacter) {
        title = comicCharacter.name
    }
}
