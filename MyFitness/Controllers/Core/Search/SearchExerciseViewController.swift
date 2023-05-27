//
//  SearchExViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/13/23.
//

import UIKit

class SearchExerciseViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - Variables
    private var searchExerciseData = [ExerciseModel]()
    private var allExerciseNameData = [String]()
    private var filteredData = [String]()
    private var isSearching = false
    
    //MARK: - UI Components
    private let spinner = CustomSpinner(size: .med,
                                        tintColor: ColorGuide.primary)
    
    lazy var searchExerciseTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchBarController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        
        addSubviews()
        setUpConstraints()
        setUpTableView()
        setUpValues()
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(spinner)
        view.addSubview(searchBarController.searchBar)
        view.addSubview(searchExerciseTableView)
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            searchExerciseTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchExerciseTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchExerciseTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchExerciseTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //  MARK: - Setup TableView
    private func setUpTableView(){
        searchExerciseTableView.delegate = self
        searchExerciseTableView.dataSource = self
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        visibleComponents(isVisible: false)
        fetchExerciseData()
    }
    
    // Fetching Data from API Call
    private func fetchExerciseData() {
        
        // Create API endpoint
        let request = Request(endpoint: .exercises)
        
        // Call API request & get response
        APICaller.shared.getExercises(URL: request.url) { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let model):
                    
                    self.searchExerciseData = model
                    self.allExerciseNameData = self.searchExerciseData.map { $0.name }
                    self.searchExerciseTableView.reloadData()
                    self.visibleComponents(isVisible: true)
                    
                case .failure(_):
                    
                    let alert = UIAlertController(title: "Error",
                                                  message: String(describing: "Error occurred while fetching exercises."),
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .default,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } // end switch
                
            } // end DispatchQueue
        }// end APICaller
        
    }
    
    //  MARK: - Visible Components
    private func visibleComponents(isVisible: Bool) {
        if isVisible {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.spinner.stopAnimating()
                self.searchExerciseTableView.isHidden = false
                UIView.animate(withDuration: 0.4){
                    self.searchExerciseTableView.alpha = 1
                }
            })
        }
        else {
            spinner.startAnimating()
            self.searchExerciseTableView.isHidden = true
            self.searchExerciseTableView.alpha = 0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            searchExerciseTableView.reloadData()
        }
        else{
            isSearching = true
            filteredData = allExerciseNameData.filter({$0.lowercased().contains(searchText.lowercased() )})
            searchExerciseTableView.reloadData()
        }
    }
    
}


// MARK: - UITableView Section
extension SearchExerciseViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredData.count : allExerciseNameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = isSearching ? filteredData[indexPath.row] : allExerciseNameData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExercise =  searchExerciseData[indexPath.row]

        let detailVC = ExerciseDetailViewController(exercise: selectedExercise)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
