//
//  UIView+Layer.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/11/22.
//

import UIKit

extension UIView {
    
    func addShadowEffect() {
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    private struct EdgeLayoutGuide {
        let topAnchor: NSLayoutYAxisAnchor
        let leftAnchor: NSLayoutXAxisAnchor
        let bottomAnchor: NSLayoutYAxisAnchor
        let rightAnchor: NSLayoutXAxisAnchor
    }
    
    @discardableResult func constrainEdgesToSuperview(with insets: UIEdgeInsets = .zero, useSafeArea: Bool = false) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            assertionFailure("Warning: Attempting to constrain edges of a view to a non-existant super view")
            return []
        }
        
        return constrainEdges(to: superview, with: insets, useSafeArea: useSafeArea)
    }
    
    @discardableResult func constrainEdges(to view: UIView, with insets: UIEdgeInsets = .zero, useSafeArea: Bool = false) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let layoutGuide = view.layoutGuide(useSafeArea: useSafeArea)
        let constraints = [
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: insets.bottom),
            rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: insets.right)
        ]
        
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    private func layoutGuide(useSafeArea: Bool) -> EdgeLayoutGuide {
        if #available(iOS 11.0, *), useSafeArea {
            return EdgeLayoutGuide(
                topAnchor: safeAreaLayoutGuide.topAnchor,
                leftAnchor: safeAreaLayoutGuide.leftAnchor,
                bottomAnchor: safeAreaLayoutGuide.bottomAnchor,
                rightAnchor: safeAreaLayoutGuide.rightAnchor
            )
        } else {
            return EdgeLayoutGuide(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor)
        }
    }
}
