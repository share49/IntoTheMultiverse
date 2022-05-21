//
//  MainCoordinator.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/21/22.
//

import UIKit
import SwiftUI

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

final class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Flows
    
    func start() {
        let logger = MLogger()
        let persistenceManager = PersistenceManager(with: logger)
        let viewModel = CharactersViewModel(logger: logger)
        let viewController = CharactersViewController(with: viewModel, coordinator: self, persistenceManager: persistenceManager, logger: logger)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func characterDetail(characterId: Int, persistenceManager: PersistenceHandler, logger: LogHandler) {
        let viewModel = CharacterDetailViewModel(characterId: characterId, persistenceManager: persistenceManager, logger: logger)
        let viewController = CharacterDetailViewController(with: viewModel, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func easterEgg() {
        let viewController = UIHostingController(rootView: EasterEggView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
