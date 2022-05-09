//
//  CharacterDetailViewController.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import UIKit
import Combine
import Kingfisher

final class CharacterDetailViewController: UIViewController {
    
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
        setupImageView()
        setupLabelDescription()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    }
    
    private func setupLabelDescription() {
        view.addSubview(lblDescription)
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        
        lblDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: k.UI.margin).isActive = true
        lblDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: k.UI.margin).isActive = true
        lblDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -k.UI.margin).isActive = true
        
        lblDescription.textAlignment = .justified
        lblDescription.numberOfLines = 0
        lblDescription.font = .preferredFont(forTextStyle: .body)
        lblDescription.adjustsFontForContentSizeCategory = true
    }
    
    private func updateUI(with comicCharacter: ComicCharacter) {
        title = comicCharacter.name
        imageView.kf.setImage(with: comicCharacter.thumbnail.url)
        lblDescription.text = comicCharacter.description
    }
}
