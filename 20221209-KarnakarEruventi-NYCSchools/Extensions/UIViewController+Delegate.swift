//
//  UIViewController+Delegate.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/11/22.
//

import UIKit

extension UIViewController: UITableViewDelegate {
    @objc var tableSectionLabel: String? {
        assertionFailure("sub class must provide tableSectionLabel")
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 50))
        let headerView = UIView(frame: headerFrame)
        headerView.backgroundColor = .white

        var labelFrame = headerFrame
        labelFrame.origin = CGPoint(x: 10, y: 5)
        let label = UILabel(frame: labelFrame)
        label.text = self.tableSectionLabel
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        headerView.addSubview(label)
        return headerView
    }
}
