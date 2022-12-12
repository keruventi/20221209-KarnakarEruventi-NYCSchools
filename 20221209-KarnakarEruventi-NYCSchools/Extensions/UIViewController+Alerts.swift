//
//  UIViewController+Alerts.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/12/22.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(withTitle title: String?, message: String?, actionTitle: String = "Ok") {
        showAlert(withTitle: title, message: message, style: .alert, actions: [UIAlertAction(title: actionTitle, style: .default)])
    }
    
    private func showAlert(withTitle title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alertController.addAction($0) }
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
