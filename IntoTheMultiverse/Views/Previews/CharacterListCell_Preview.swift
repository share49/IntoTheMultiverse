//
//  CharacterListCell_Preview.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/18/22.
//

import SwiftUI

struct CharacterListCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = CharacterListCell()
        let viewModel = CharacterListCellViewModel(with: ComicCharacter.previewData)
        cell.setup(with: viewModel)
        return cell
    }
    
    func updateUIView(_ view: UIView, context: Context) {
    }
}

struct CharacterListCell_Preview: PreviewProvider {
    static var previews: some View {
        CharacterListCellRepresentable()
            .previewLayout(.sizeThatFits)
    }
}
