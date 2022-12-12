//
//  HomeViewController.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/9/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var schoolDataItems = [DirectoryModel]()
    private var filteredDataItems = [DirectoryModel]()
    private let pageSize = 10
    private var pageOffset = 0
    private var totalItems = 100
    private var shouldShowLoadingCell = false
    private var searchActive: Bool = false
    private lazy var activitySpinner = ActivitySpinnerView.instanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "NYC Schools"

        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        loadData()
    }
    
    
    private func fetchNextPage() {
        pageOffset += pageSize
        loadData()
    }
    
    func loadData() {
        DataService.shared.getShoolData(limit: pageSize, offset: pageOffset) { result in
            switch result {
            case .success(let items):
                if !items.isEmpty {
                    self.schoolDataItems.append(contentsOf: items)
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
        return indexPath.row == self.schoolDataItems.count
    }
    
    private func prepareDetailsScreenData(_ directoryVM: DirectoryViewModel) {
        activitySpinner.startAnimating(in: view)
        DataService.shared.getResultsDetails(dbn: directoryVM.id) { result in
            switch result {
            case .success(let item):
                if !item.isEmpty {
                    let resultVM = ResultViewModel(modelObj: item[0])
                    let viewModel = SchoolDetailsViewModel(schoolVM: directoryVM, resultVM: resultVM)
                    self.presentDetailScreen(with: viewModel)
                } else {
                    self.showSimpleAlert(withTitle: "", message: "Data Not Available.")
                }
                self.activitySpinner.stopAnimating()
            case .failure(let error):
                self.showSimpleAlert(withTitle: "Error", message: "Data Not Available.")
                self.activitySpinner.stopAnimating()
                print("Schoola Details Not Available. \(error.localizedDescription)")
            }
        }
    }
    
    private func presentDetailScreen(with viewModel: SchoolDetailsViewModel) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SchoolDetalsViewController") as? SchoolDetalsViewController else { return }
        controller.viewModel = viewModel
        self.present(controller, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    override var tableSectionLabel: String? {
        return "School Directory"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredDataItems.count
        } else {
            let count = schoolDataItems.count
            return shouldShowLoadingCell ? count + 1 : count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        fetchNextPage()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingIndexPath(indexPath) {
            return tableView.dequeueReusableCell(withIdentifier: "LoaderTableViewCell", for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SchoolDataTableViewCell.self)
            let dataItem = searchActive ? filteredDataItems[indexPath.row] : schoolDataItems[indexPath.row]
            let viewModel = DirectoryViewModel(modelObj: dataItem)
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataItem = searchActive ? filteredDataItems[indexPath.row] : schoolDataItems[indexPath.row]
        let viewModel = DirectoryViewModel(modelObj: dataItem)
        prepareDetailsScreenData(viewModel)
    }
    
}

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            filteredDataItems = schoolDataItems.filter({ item in
                guard let name = item.schoolName else { return false}
                return name.contains(searchText)
            })
            
            searchActive = filteredDataItems.count == 0 ? false : true
            
        } else {
            searchActive = false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
