//
//  ErrorPresentable.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/10/22.
//

import UIKit

protocol ErrorPresentable {
    func presentOKAlert(withTitle title: String, errorMessage: String, animated: Bool)
}

extension ErrorPresentable where Self: UIViewController {
    
    func presentOKAlert(withTitle title: String = k.ViewsText.alertTitleError, errorMessage: String, animated: Bool = true) {
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: k.ViewsText.ok, style: .default))
        present(alertController, animated: animated)
    }
}
