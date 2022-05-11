//
//  ActivityPresentable.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/10/22.
//

import UIKit

protocol ActivityPresentable {
    func showActivityIndicator(topDistance: CGFloat)
    func hideActivityIndicator()
}

extension ActivityPresentable where Self: UIViewController {
    
    func showActivityIndicator(topDistance: CGFloat = Constants.UI.margin) {
        if let activityIndicator = findActivityIndicator() {
            activityIndicator.startAnimating()
        } else {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
            
            view.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topDistance).isActive = true
            activityIndicator.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            activityIndicator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
    }
    
    func hideActivityIndicator() {
        findActivityIndicator()?.stopAnimating()
    }
    
    private func findActivityIndicator() -> UIActivityIndicatorView? {
        view.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }
}
