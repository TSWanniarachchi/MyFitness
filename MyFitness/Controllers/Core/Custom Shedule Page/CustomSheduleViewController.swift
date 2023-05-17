//
//  CustomScheduleViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/13/23.
//

import UIKit

class CustomScheduleViewController: UIViewController {
    
    //MARK: - Variables
    var CustomScheduleExerciseData = [ExerciseModel]()
    var ResponseData = [ResponseModel]()
    
    //MARK: - UI Components
    private let spinner = CustomSpinner(size: .med,
                                        tintColor: ColorGuide.primary)
    
    private let coverImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                 imageType: .page,
                                                 imageLayout: .dark)
    
    private let customScheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CustomScheduleExerciseTableViewCell.self, forCellReuseIdentifier: CustomScheduleExerciseTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubviews()
        setUpConstraints()
        setUpTableView()
        setUpValues()
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(spinner)
        view.addSubview(coverImageView)
        view.addSubview(customScheduleTableView)
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            coverImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            coverImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 120),
            
            customScheduleTableView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 5),
            customScheduleTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customScheduleTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            customScheduleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    //  MARK: - Setup TableView
    private func setUpTableView(){
        customScheduleTableView.delegate = self
        customScheduleTableView.dataSource = self
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        coverImageView.image = UIImage(named: "cover_custom-schedule")
        
        visibleComponents(isVisible: false)
        fetchCustomScheduleExercisesData(userId: "sachin")
    }
    
    // Fetching Data from API Call
    private func fetchCustomScheduleExercisesData(userId: String) {

        // Create API request
        let request = Request(endpoint: .customSchedules,
                              pathComponents: [userId])

        // Call API request & get response
        APICaller.shared.getCustomSchedules(URL: request.url) { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let model):

                    self.CustomScheduleExerciseData = model
                    self.customScheduleTableView.reloadData()
                    
                    self.visibleComponents(isVisible: true)

                case .failure(_):

                    let alert = UIAlertController(title: "Error",
                                                  message: String(describing: "Error occurred while fetching custom schedule exercises."),
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .default,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } // end switch

            } // end DispatchQueue
        }// end APICaller
        
    }
    
    // Delete Data API Call
    private func deleteCustomScheduleExercisesData(userId: String, exerciseId : String){
        
        // Create API request
        let request = Request(endpoint: .customSchedules,
                              pathComponents: [userId,
                                               exerciseId])
        
        // Call API request & get response
        APICaller.shared.deleteCustomSchedules(URL: request.url) {
            result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let model):
                    
                    self.ResponseData = model

                    if(self.ResponseData[0].success == true){
                        let alert = UIAlertController(title: "Alert",
                                                      message: "Exercise \(self.ResponseData[0].message)",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .default,
                                                      handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        let alert = UIAlertController(title: "Error",
                                                      message: String(describing: self.ResponseData[0].message),
                                                      preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Dismise",
                                                      style: UIAlertAction.Style.default,
                                                      handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                case .failure(let error):
                    
                    let alert = UIAlertController(title: "Error",
                                                  message: String(describing: error),
                                                  preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: UIAlertAction.Style.default,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } // end switch
                
            } // end DispatchQueue
            
        } // end APICaller
        
    }
    
    private func visibleComponents(isVisible: Bool) {
        if isVisible {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.spinner.stopAnimating()
                
                self.customScheduleTableView.isHidden = false
                self.coverImageView.isHidden = false
                UIView.animate(withDuration: 0.4){
                    self.customScheduleTableView.alpha = 1
                    self.coverImageView.alpha = 1
                }
            })
        }
        else {
            spinner.startAnimating()
            
            self.coverImageView.isHidden = true
            self.coverImageView.alpha = 0
            self.customScheduleTableView.isHidden = true
            self.customScheduleTableView.alpha = 0
        }
    }
    
}


// MARK: - UITableView Section
extension CustomScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomScheduleExerciseData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomScheduleExerciseTableViewCell.identifier,
            for: indexPath
        ) as? CustomScheduleExerciseTableViewCell else {
            fatalError("Unsupported Cell")
        }
        
        cell.setUpValues(customScheduleExercise: CustomScheduleExerciseData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExercise =  CustomScheduleExerciseData[indexPath.row]
        
        let detailVC = ExerciseDetailViewController(exercise: selectedExercise)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "") {action, view, completion in

            // API Call
            let selectedExercise =  self.CustomScheduleExerciseData[indexPath.row]
            self.deleteCustomScheduleExercisesData(userId: "sachin", exerciseId: selectedExercise.id)
            
            // Remove Table View
            self.CustomScheduleExerciseData.remove(at: indexPath.row)
            self.customScheduleTableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        return actions
    }
    
}
