//
//  ResultsTableViewCell.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/11/22.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet private var cardView: UIView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var idLabel: UILabel!
    @IBOutlet private var attendeesLabel: UILabel!
    @IBOutlet private var readingScoreLabel: UILabel!
    @IBOutlet private var writingScoreLabel: UILabel!
    @IBOutlet private var mathScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleComponents()
    }
    
    func styleComponents() {
        cardView.addShadowEffect()
    }

    func configure(with viewModel: ResultViewModel) {
        nameLabel.text = viewModel.schoolName
        idLabel.text = viewModel.schoolId
        attendeesLabel.text = viewModel.numOfSatTestTakers
        readingScoreLabel.text = viewModel.readingScoreLabel
        writingScoreLabel.text = viewModel.writingScoreLabel
        mathScoreLabel.text = viewModel.mathScoreLabel
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
