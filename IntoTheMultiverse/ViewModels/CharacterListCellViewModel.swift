//
//  CharacterListCellViewModel.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/18/22.
//

import Foundation

final class CharacterListCellViewModel {
    
    // MARK: - Properties
    
    private let comicCharacter: ComicCharacter
    var title: String {
        comicCharacter.name
    }
    var thumbnailURL: URL? {
        comicCharacter.thumbnail.url(for: .squareMedium)
    }
    
    // MARK: - Initializer
    
    init(with comicCharacter: ComicCharacter) {
        self.comicCharacter = comicCharacter
    }
}
