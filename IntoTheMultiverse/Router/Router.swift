//
//  Router.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import UIKit

protocol RouterProtocol {
    associatedtype Destination
    func navigate(to destination: Destination)
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
    func navigate(to destination: Destination) {
        DispatchQueue.main.async {
            let viewController = self.makeViewController(for: destination)
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - Support methods
    
    /// Makes the destination view controller
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .characterDetail(let characterId):
            return getCharacterDetailVC(for: characterId)
        }
    }
    
    /// Creates CharacterDetailViewController for the character id
    private func getCharacterDetailVC(for characterId: Int) -> UIViewController {
        UIViewController()
    }
}
