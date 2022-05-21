//
//  Router.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import UIKit
import SwiftUI

protocol RouterProtocol {
    associatedtype Destination
    func navigate(to destination: Destination, animated: Bool)
}

struct Router: RouterProtocol {
    
    // MARK: - Properties
    
    private let navigationController: UINavigationController
    
    // MARK: - Initializer

    /// Initialize Router with current navigation controller
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Interface
    
    /// Pushes the selected destination view
    func navigate(to destination: Destination, animated: Bool = true) {
        let viewController = makeViewController(for: destination)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - Support methods
    
    /// Makes the destination view controller
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .characterDetail(let viewModel, let logger):
            return getCharacterDetailVC(for: viewModel, logger: logger)
            
        case .easterEggView:
            return getEasterEggView()
        }
    }
    
    /// Creates CharacterDetailViewController for the character id
    private func getCharacterDetailVC(for viewModel: CharacterDetailViewModel, logger: LogHandler) -> UIViewController {
        CharacterDetailViewController(with: viewModel, logger: logger)
    }
    
    /// Creates a HostingController to show the SwiftUI view
    private func getEasterEggView() -> UIViewController {
        UIHostingController(rootView: EasterEggView())
    }
}
