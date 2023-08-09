//
//  UIViewController+Ext.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 09/08/2023.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
