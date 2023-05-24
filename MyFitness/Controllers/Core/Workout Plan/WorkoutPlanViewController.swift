//
//  WorkoutPlanViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/17/23.
//

import UIKit

class WorkoutPlanViewController: UIViewController {
    
    //MARK: - Variables
    var WorkoutPlanExerciseData = [ExerciseModel]()
    
    //MARK: - UI Components
    private let spinner = CustomSpinner(size: .med,
                                        tintColor: ColorGuide.primary)
    
    private let headerLabel = CustomLabel(labelType: .header3,
                                          textColor: .label,
                                          textAlignment: .left)
    
    private let heightLabel = CustomLabel(labelType: .card,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let weightLabel = CustomLabel(labelType: .card,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let bmiLabel = CustomLabel(labelType: .card,
                                       textColor: .label,
                                       textAlignment: .center)
    
    private let horizontalLine = CustomHorizontalBar(backgroundColor: ColorGuide.secondary)
    
    private let aboutLabel = CustomLabel(labelType: .header5,
                                       textColor: .label,
                                       textAlignment: .center)
    
    private let previewButton = CustomButton(buttonType: .primary,
                                               title: "Day 1",
                                               fontsize: .med)
    
    private let startButton = CustomButton(buttonType: .secondary,
                                               title: "Day 2",
                                               fontsize: .med)
    
    private let nextButton = CustomButton(buttonType: .secondary,
                                               title: "Day 3",
                                               fontsize: .med)
    
    private let workoutPlanTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(WorkoutPlanExerciseTableViewCell.self, forCellReuseIdentifier: WorkoutPlanExerciseTableViewCell.identifier)
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
        view.addSubview(heightLabel)
        view.addSubview(headerLabel)
        view.addSubview(weightLabel)
        view.addSubview(bmiLabel)
        view.addSubview(horizontalLine)
        view.addSubview(aboutLabel)
        view.addSubview(previewButton)
        view.addSubview(startButton)
        view.addSubview(nextButton)
        view.addSubview(workoutPlanTableView)
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            heightLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            heightLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            heightLabel.widthAnchor.constraint(equalToConstant: 110),
            heightLabel.heightAnchor.constraint(equalToConstant: 100),
            
            weightLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            weightLabel.leftAnchor.constraint(equalTo: heightLabel.rightAnchor, constant: 5),
            weightLabel.widthAnchor.constraint(equalToConstant: 110),
            weightLabel.heightAnchor.constraint(equalToConstant: 100),
            
            bmiLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            bmiLabel.leftAnchor.constraint(equalTo: weightLabel.rightAnchor, constant: 5),
            bmiLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            bmiLabel.heightAnchor.constraint(equalToConstant: 100),
            
            horizontalLine.topAnchor.constraint(equalTo: bmiLabel.bottomAnchor, constant: 10),
            horizontalLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            horizontalLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            
            aboutLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 7),
            aboutLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            aboutLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
           
            previewButton.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 7),
            previewButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            previewButton.heightAnchor.constraint(equalToConstant: 30),
            previewButton.widthAnchor.constraint(equalToConstant: 100),
            
            startButton.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 7),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 30),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            
            nextButton.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 7),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            nextButton.heightAnchor.constraint(equalToConstant: 30),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            
            workoutPlanTableView.topAnchor.constraint(equalTo: previewButton.bottomAnchor, constant: 2),
            workoutPlanTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            workoutPlanTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            workoutPlanTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

    }
    
    //  MARK: - Setup TableView
    private func setUpTableView(){
        workoutPlanTableView.delegate = self
        workoutPlanTableView.dataSource = self
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        visibleComponents(isVisible: false)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left

        let headerAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 21, weight: .bold),
            .paragraphStyle: paragraphStyle
        ]
        let keyAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.label
        ]
        let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 21, weight: .bold),
        ]
        let highlitedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 21, weight: .bold),
            .foregroundColor: UIColor.systemGreen
            ]
        
        let attributedHeightText = NSMutableAttributedString()
        attributedHeightText.append(NSAttributedString(string: "75 KG", attributes: valueAttributes))
        attributedHeightText.append(NSAttributedString(string: "\n"))
        attributedHeightText.append(NSAttributedString(string: "Height", attributes: keyAttributes))
        heightLabel.attributedText = attributedHeightText

        let attributedWeightText = NSMutableAttributedString()
        attributedWeightText.append(NSAttributedString(string: "165 CM", attributes: valueAttributes))
        attributedWeightText.append(NSAttributedString(string: "\n"))
        attributedWeightText.append(NSAttributedString(string: "Weight", attributes: keyAttributes))
        weightLabel.attributedText = attributedWeightText

        let attributedBMIText = NSMutableAttributedString()
        attributedBMIText.append(NSAttributedString(string: "26 (Normal)", attributes: highlitedAttributes))
        attributedBMIText.append(NSAttributedString(string: "\n"))
        attributedBMIText.append(NSAttributedString(string: "BMI Level", attributes: keyAttributes))
        bmiLabel.attributedText = attributedBMIText
        
        let attributedAboutText = NSMutableAttributedString()
        attributedAboutText.append(NSAttributedString(string: "Your Workout Plan", attributes: headerAttributes))
        attributedAboutText.append(NSAttributedString(string: "\n"))
        attributedAboutText.append(NSAttributedString(string: "Duration: 3 Months, 3 days a week", attributes: keyAttributes))
        attributedAboutText.append(NSAttributedString(string: "\n"))
        attributedAboutText.append(NSAttributedString(string: "Goal : Muscle building for beginner", attributes: keyAttributes))
        aboutLabel.attributedText = attributedAboutText
        
        headerLabel.text = "Your Current BMI"
   
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
                    
                    self.WorkoutPlanExerciseData = model
                    self.workoutPlanTableView.reloadData()
                    
                    self.visibleComponents(isVisible: true)
                    
                case .failure(_):
                    
                    let alert = UIAlertController(title: "Error",
                                                  message: String(describing: "Error occurred while fetching workout plan exercises."),
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .default,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } // end switch
                
            } // end DispatchQueue
        }// end APICaller
        
    }
    
    private func visibleComponents(isVisible: Bool) {
        if isVisible {
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.spinner.stopAnimating()
                
                self.headerLabel.isHidden = false
                self.aboutLabel.isHidden = false
                self.heightLabel.isHidden = false
                self.weightLabel.isHidden = false
                self.bmiLabel.isHidden = false
                self.horizontalLine.isHidden = false
                self.previewButton.isHidden = false
                self.startButton.isHidden = false
                self.nextButton.isHidden = false
                self.workoutPlanTableView.isHidden = false
                
                UIView.animate(withDuration: 0.4){
                    self.headerLabel.alpha = 1
                    self.aboutLabel.alpha = 1
                    self.heightLabel.alpha = 1
                    self.weightLabel.alpha = 1
                    self.bmiLabel.alpha = 1
                    self.horizontalLine.alpha = 1
                    self.previewButton.alpha = 1
                    self.startButton.alpha = 1
                    self.nextButton.alpha = 1
                    self.workoutPlanTableView.alpha = 1
                }
            })
        }
        else {
            spinner.startAnimating()
            
            self.headerLabel.isHidden = true
            self.headerLabel.alpha = 0
            self.aboutLabel.isHidden = true
            self.aboutLabel.alpha = 0
            self.heightLabel.isHidden = true
            self.heightLabel.alpha = 0
            self.weightLabel.isHidden = true
            self.weightLabel.alpha = 0
            self.bmiLabel.isHidden = true
            self.bmiLabel.alpha = 0
            self.horizontalLine.isHidden = true
            self.horizontalLine.alpha = 0
            self.previewButton.isHidden = true
            self.previewButton.alpha = 0
            self.startButton.isHidden = true
            self.startButton.alpha = 0
            self.nextButton.isHidden = true
            self.nextButton.alpha = 0
            self.workoutPlanTableView.isHidden = true
            self.workoutPlanTableView.alpha = 0
        }
    }
    
}


// MARK: - UITableView Section
extension WorkoutPlanViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkoutPlanExerciseData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WorkoutPlanExerciseTableViewCell.identifier,
            for: indexPath
        ) as? WorkoutPlanExerciseTableViewCell else {
            fatalError("Unsupported Cell")
        }
        
        cell.setUpValues(workoutPlanExercise: WorkoutPlanExerciseData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExercise =  WorkoutPlanExerciseData[indexPath.row]
        
        let detailVC = ExerciseDetailViewController(exercise: selectedExercise)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
