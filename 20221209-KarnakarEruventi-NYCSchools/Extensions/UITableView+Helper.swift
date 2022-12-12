//
//  UITableView+Helper.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/11/22.
//

import Foundation
import UIKit

public extension UITableView {
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell for identifier \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

public extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
