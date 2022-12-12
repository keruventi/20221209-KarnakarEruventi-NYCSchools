//
//  SchoolDataTableViewCell.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/11/22.
//

import UIKit

class SchoolDataTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var gradesLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleComponents()
    }
    
    func styleComponents() {
        cardView.addShadowEffect()
    }

    func configure(with viewModel: DirectoryViewModel) {
        nameLabel.text = viewModel.schoolName
        idLabel.text = viewModel.schoolId
        gradesLabel.text = viewModel.grades
        seatsLabel.text = viewModel.totalStudents
        addressLabel.text = viewModel.address
        phoneLabel.text = viewModel.phoneNumber
        emailLabel.text = viewModel.email
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
