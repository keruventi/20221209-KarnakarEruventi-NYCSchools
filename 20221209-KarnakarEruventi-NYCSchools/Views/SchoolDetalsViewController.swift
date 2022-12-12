//
//  SchoolDetalsViewController.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/11/22.
//

import UIKit

class SchoolDetalsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var dbnLabel: UILabel!
    @IBOutlet weak var gradesLabel: UILabel!
    @IBOutlet weak var overviewTextView: UILabel!
    @IBOutlet weak var campusLabel: UILabel!
    @IBOutlet weak var elgibilityLabel: UILabel!
    @IBOutlet weak var sportsLabel: UILabel!
    @IBOutlet weak var timingsLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var attendessLabel: UILabel!
    @IBOutlet weak var fullAddressLabel: UILabel!
    
    var viewModel: SchoolDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleComponents()
        configureData()
    }
    
    
    func styleComponents() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    }

    func configureData() {
        guard let viewModel = viewModel else { return }
        schoolName.text = viewModel.schoolName
        dbnLabel.text = viewModel.schoolId
        gradesLabel.text = viewModel.grades
        overviewTextView.text = viewModel.overviewText
        campusLabel.text = viewModel.campusName
        elgibilityLabel.text = viewModel.eligibilityText
        sportsLabel.text = viewModel.sportsText
        timingsLabel.text = viewModel.timingsText
        readingLabel.text = viewModel.readingScore
        writingLabel.text = viewModel.writingScore
        mathLabel.text = viewModel.mathScore
        totalLabel.text = viewModel.totalStudents
        attendessLabel.text = viewModel.numOfSatTestTakers
        fullAddressLabel.text = viewModel.address
    }

}
