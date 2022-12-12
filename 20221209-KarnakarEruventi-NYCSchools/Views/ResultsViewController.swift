//
//  ResultsViewController.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/9/22.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var schoolResultItems = [ResultModel]()
    private let pageSize = 10
    private var pageOffset = 0
    private var totalItems = 100
    private var shouldShowLoadingCell = false
    private lazy var activitySpinner = ActivitySpinnerView.instanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        loadData()
    }
    
    private func fetchNextPage() {
        pageOffset += pageSize
        loadData()
    }
    
    func loadData() {
        DataService.shared.getResultData(limit: pageSize, offset: pageOffset) { result in
            switch result {
            case .success(let items):
                if !items.isEmpty {
                    self.schoolResultItems.append(contentsOf: items)
                }
                self.shouldShowLoadingCell = self.pageOffset < self.totalItems
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.shouldShowLoadingCell = false
                print("Schoola Data Not Available. \(error.localizedDescription)")
            }
        }
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == self.schoolResultItems.count
    }
    
    private func prepareDetailsScreenData(with resultVM: ResultViewModel) {
        activitySpinner.startAnimating(in: view)
        DataService.shared.getShoolDetails(dbn: resultVM.id) { result in
            switch result {
            case .success(let item):
                if !item.isEmpty {
                    let directoryVM = DirectoryViewModel(modelObj: item[0])
                    let viewModel = SchoolDetailsViewModel(schoolVM: directoryVM, resultVM: resultVM)
                    self.presentDetailScreen(with: viewModel)
                } else {
                    self.showSimpleAlert(withTitle: "", message: "Data Not Available.")
                }
                self.activitySpinner.stopAnimating()
            case .failure(let error):
                self.showSimpleAlert(withTitle: "Error", message: "Data Not Available.")
                self.activitySpinner.stopAnimating()
                print("Schoola Data Not Available. \(error.localizedDescription)")
            }
        }
    }
    
    private func presentDetailScreen(with viewModel: SchoolDetailsViewModel) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SchoolDetalsViewController") as? SchoolDetalsViewController else { return }
        controller.viewModel = viewModel
        self.present(controller, animated: true)
    }
}

extension ResultsViewController: UITableViewDataSource {
    
    override var tableSectionLabel: String? {
        return "SAT Results"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = schoolResultItems.count
        return shouldShowLoadingCell ? count + 1 : count
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        fetchNextPage()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingIndexPath(indexPath) {
            return tableView.dequeueReusableCell(withIdentifier: "LoaderTableViewCell", for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ResultsTableViewCell.self)
            let viewModel = ResultViewModel(modelObj: schoolResultItems[indexPath.row])
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = ResultViewModel(modelObj: schoolResultItems[indexPath.row])
        self.prepareDetailsScreenData(with: viewModel)
    }
    
}
