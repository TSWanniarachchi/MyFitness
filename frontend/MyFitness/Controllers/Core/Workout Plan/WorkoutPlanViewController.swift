//
//  WorkoutPlanViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/17/23.
//

import UIKit

class WorkoutPlanViewController: UIViewController {
    
    //MARK: - Variables
    private var WorkoutPlanExerciseData = [ExerciseModel]()
    private var exerciseNameList = [String]()
    private var exerciseBurnedCalList = [Int]()
    private var nameIndex = 0
    private var progressLevel = 6
    private var progress = 0
    private var timer: Timer?
    private var elapsedTime: TimeInterval = 0
    private var isStart = false
    
    //MARK: - UI Components
    private let spinner = CustomSpinner(size: .med,
                                        tintColor: ColorGuide.primary)
    
    private let headerLabel = CustomLabel(labelType: .header1,
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
    
    private let horizontalLine1 = CustomHorizontalBar(backgroundColor: ColorGuide.secondary)
    
    private let aboutLabel = CustomLabel(labelType: .header5,
                                         textColor: .label,
                                         textAlignment: .left)
    
    private let exerciseLabel = CustomLabel(labelType: .header4,
                                            textColor: .label,
                                            textAlignment: .left)
    
    private let timeLabel = CustomLabel(labelType: .header4,
                                        textColor: .label,
                                        textAlignment: .right)
    
    private let previousButton = CustomImageButton(image: UIImage(systemName: "backward.circle.fill")!,
                                                   pointSize: 35,
                                                   cornerRadius: 25,
                                                   tintColor: ColorGuide.primary,
                                                   backgroundColor: .secondarySystemBackground)
    
    private let startButton = CustomImageButton(image: UIImage(systemName: "playpause.circle.fill")!,
                                                pointSize: 35,
                                                cornerRadius: 25,
                                                tintColor: ColorGuide.primary,
                                                backgroundColor: .secondarySystemBackground)
    
    private let nextButton = CustomImageButton(image: UIImage(systemName: "forward.circle.fill")!,
                                               pointSize: 35,
                                               cornerRadius: 25,
                                               tintColor: ColorGuide.primary,
                                               backgroundColor: .secondarySystemBackground)
    
    private let doneButton = CustomImageButton(image: UIImage(systemName: "hand.thumbsup.circle.fill")!,
                                               pointSize: 35,
                                               cornerRadius: 25,
                                               tintColor: ColorGuide.primary,
                                               backgroundColor: .secondarySystemBackground)
    
    private let progressLabel = CustomLabel(labelType: .card,
                                            textColor: .label,
                                            textAlignment: .center)
    
    private let horizontalLine2 = CustomHorizontalBar(backgroundColor: ColorGuide.secondary)
    
    private let day1Button = CustomButton(buttonType: .primary,
                                          title: "Day 1",
                                          fontsize: .med)
    
    private let day2Button = CustomButton(buttonType: .secondary,
                                          title: "Day 2",
                                          fontsize: .med)
    
    private let day3Button = CustomButton(buttonType: .secondary,
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
        
        day1Button.addTarget(self, action: #selector(didTapDay1Button), for: .touchUpInside)
        day2Button.addTarget(self, action: #selector(didTapDay2Button), for: .touchUpInside)
        day3Button.addTarget(self, action: #selector(didTapDay3Button), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(didTapDoneiousButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(spinner)
        view.addSubview(headerLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        view.addSubview(bmiLabel)
        view.addSubview(horizontalLine1)
        view.addSubview(aboutLabel)
        view.addSubview(exerciseLabel)
        view.addSubview(timeLabel)
        view.addSubview(previousButton)
        view.addSubview(startButton)
        view.addSubview(nextButton)
        view.addSubview(doneButton)
        view.addSubview(progressLabel)
        view.addSubview(horizontalLine2)
        view.addSubview(day1Button)
        view.addSubview(day2Button)
        view.addSubview(day3Button)
        view.addSubview(workoutPlanTableView)
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            heightLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            heightLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            heightLabel.widthAnchor.constraint(equalToConstant: 110),
            heightLabel.heightAnchor.constraint(equalToConstant: 80),
            
            weightLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            weightLabel.leftAnchor.constraint(equalTo: heightLabel.rightAnchor, constant: 5),
            weightLabel.widthAnchor.constraint(equalToConstant: 110),
            weightLabel.heightAnchor.constraint(equalToConstant: 80),
            
            bmiLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            bmiLabel.leftAnchor.constraint(equalTo: weightLabel.rightAnchor, constant: 5),
            bmiLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            bmiLabel.heightAnchor.constraint(equalToConstant: 80),
            
            horizontalLine1.topAnchor.constraint(equalTo: bmiLabel.bottomAnchor, constant: 10),
            horizontalLine1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            horizontalLine1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            horizontalLine1.heightAnchor.constraint(equalToConstant: 1),
            
            aboutLabel.topAnchor.constraint(equalTo: horizontalLine1.bottomAnchor, constant: 5),
            aboutLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            aboutLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            exerciseLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10),
            exerciseLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            timeLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10),
            timeLabel.leftAnchor.constraint(equalTo: exerciseLabel.rightAnchor, constant: 5),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            previousButton.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 7),
            previousButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            previousButton.heightAnchor.constraint(equalToConstant: 50),
            previousButton.widthAnchor.constraint(equalToConstant: 50),
            
            startButton.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 7),
            startButton.leftAnchor.constraint(equalTo: previousButton.rightAnchor, constant: 8),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 50),
            
            nextButton.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 7),
            nextButton.leftAnchor.constraint(equalTo: startButton.rightAnchor, constant: 8),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            
            doneButton.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 7),
            doneButton.leftAnchor.constraint(equalTo: nextButton.rightAnchor, constant: 8),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.widthAnchor.constraint(equalToConstant: 50),
            
            progressLabel.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 7),
            progressLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            progressLabel.heightAnchor.constraint(equalToConstant: 50),
            progressLabel.widthAnchor.constraint(equalToConstant: 150),
            
            horizontalLine2.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 10),
            horizontalLine2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            horizontalLine2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            horizontalLine2.heightAnchor.constraint(equalToConstant: 1),
            
            day1Button.topAnchor.constraint(equalTo: horizontalLine2.bottomAnchor, constant: 8),
            day1Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            day1Button.heightAnchor.constraint(equalToConstant: 30),
            day1Button.widthAnchor.constraint(equalToConstant: 85),
            
            day2Button.topAnchor.constraint(equalTo: horizontalLine2.bottomAnchor, constant: 8),
            day2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            day2Button.heightAnchor.constraint(equalToConstant: 30),
            day2Button.widthAnchor.constraint(equalToConstant: 85),
            
            day3Button.topAnchor.constraint(equalTo: horizontalLine2.bottomAnchor, constant: 8),
            day3Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            day3Button.heightAnchor.constraint(equalToConstant: 30),
            day3Button.widthAnchor.constraint(equalToConstant: 85),
            
            workoutPlanTableView.topAnchor.constraint(equalTo: day3Button.bottomAnchor, constant: 2),
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
        fetchExerciseData(category: AuthManager.fitnessGoal)
        
        let height = AuthManager.height
        let feet = Int(height) // Extract the whole number part feet
        let inches = Int((height - Double(feet)) * 100) // Extract the fractional part and convert it to inches
        let heightMeters = Double(feet) * 0.3048 + Double(inches) * 0.0254 // Convert feet and inches to meters
        let weight = AuthManager.weight
        let bmi = weight / (heightMeters * heightMeters)
        let fitnessGoal = AuthManager.fitnessGoal.replacingOccurrences(of: "_", with: " ")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        let keyAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.label
        ]
        let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 21, weight: .bold),
        ]
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
        ]
        let highlitedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 21, weight: .bold),
            .foregroundColor: UIColor.systemGreen
        ]
        
        let attributedHeightText = NSMutableAttributedString()
        attributedHeightText.append(NSAttributedString(string: "\(height) FT", attributes: valueAttributes))
        attributedHeightText.append(NSAttributedString(string: "\n"))
        attributedHeightText.append(NSAttributedString(string: "Height", attributes: keyAttributes))
        heightLabel.attributedText = attributedHeightText
        
        let attributedWeightText = NSMutableAttributedString()
        attributedWeightText.append(NSAttributedString(string: "\(weight) KG", attributes: valueAttributes))
        attributedWeightText.append(NSAttributedString(string: "\n"))
        attributedWeightText.append(NSAttributedString(string: "Weight", attributes: keyAttributes))
        weightLabel.attributedText = attributedWeightText
        
        let attributedBMIText = NSMutableAttributedString()
        attributedBMIText.append(NSAttributedString(string: "\(String(format: "%.1f", bmi)) Normal", attributes: highlitedAttributes))
        attributedBMIText.append(NSAttributedString(string: "\n"))
        attributedBMIText.append(NSAttributedString(string: "BMI Level", attributes: keyAttributes))
        bmiLabel.attributedText = attributedBMIText
        
        let attributedAboutText = NSMutableAttributedString()
        attributedAboutText.append(NSAttributedString(string: "Goal : \(fitnessGoal), 3 months  3 days / week", attributes: textAttributes))
        aboutLabel.attributedText = attributedAboutText
        
        headerLabel.text = "Your BMI & Workout Plan"
        progressLabel.text = "Progress \(progress)/\(progressLevel + 1)"
        exerciseLabel.text = "Push-Ups"
        timeLabel.text = "Time : 00:00"
    }
    
    // Fetching Data from API Call
    private func fetchExerciseData(category: String) {
        
        // Create API request
        let request = Request(endpoint: .exercises,
                              pathComponents: ["group", category])
        
        // Call API request & get response
        APICaller.shared.getExercises(URL: request.url) { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let model):
                    
                    self.WorkoutPlanExerciseData = model
                    self.exerciseNameList = model.map { $0.name }
                    self.exerciseBurnedCalList = model.map {$0.burnedCalories}
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
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func stopTimer() {
            timer?.invalidate()
        }
    
    @objc private func resetTimer() {
        timer?.invalidate()
        elapsedTime = 0
        updateTimeLabel()
        }
    
    @objc private func updateTime() {
        elapsedTime += 1
        updateTimeLabel()
    }
    
    private func updateTimeLabel() {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        timeLabel.text = String(format: "Time : %02d:%02d", minutes, seconds)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    private func visibleComponents(isVisible: Bool) {
        if isVisible {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.spinner.stopAnimating()
                
                //                self.headerLabel.isHidden = false
                self.heightLabel.isHidden = false
                self.weightLabel.isHidden = false
                self.bmiLabel.isHidden = false
                self.horizontalLine1.isHidden = false
                self.aboutLabel.isHidden = false
                self.exerciseLabel.isHidden = false
                self.timeLabel.isHidden = false
                self.previousButton.isHidden = false
                self.startButton.isHidden = false
                self.nextButton.isHidden = false
                self.doneButton.isHidden = false
                self.progressLabel.isHidden = false
                self.horizontalLine2.isHidden = false
                self.day1Button.isHidden = false
                self.day2Button.isHidden = false
                self.day3Button.isHidden = false
                self.workoutPlanTableView.isHidden = false
                
                UIView.animate(withDuration: 0.4){
                    //                    self.headerLabel.alpha = 1
                    self.heightLabel.alpha = 1
                    self.weightLabel.alpha = 1
                    self.bmiLabel.alpha = 1
                    self.horizontalLine1.alpha = 1
                    self.aboutLabel.alpha = 1
                    self.exerciseLabel.alpha = 1
                    self.timeLabel.alpha = 1
                    self.previousButton.alpha = 1
                    self.startButton.alpha = 1
                    self.nextButton.alpha = 1
                    self.doneButton.alpha = 1
                    self.progressLabel.alpha = 1
                    self.horizontalLine2.alpha = 1
                    self.day1Button.alpha = 1
                    self.day2Button.alpha = 1
                    self.day3Button.alpha = 1
                    self.workoutPlanTableView.alpha = 1
                }
            })
        }
        else {
            spinner.startAnimating()
            
            //            self.headerLabel.isHidden = true
            //            self.headerLabel.alpha = 0
            self.heightLabel.isHidden = true
            self.heightLabel.alpha = 0
            self.weightLabel.isHidden = true
            self.weightLabel.alpha = 0
            self.bmiLabel.isHidden = true
            self.bmiLabel.alpha = 0
            self.horizontalLine1.isHidden = true
            self.horizontalLine1.alpha = 0
            self.aboutLabel.isHidden = true
            self.aboutLabel.alpha = 0
            self.exerciseLabel.isHidden = true
            self.exerciseLabel.alpha = 0
            self.timeLabel.isHidden = true
            self.timeLabel.alpha = 0
            self.previousButton.isHidden = true
            self.previousButton.alpha = 0
            self.startButton.isHidden = true
            self.startButton.alpha = 0
            self.nextButton.isHidden = true
            self.nextButton.alpha = 0
            self.doneButton.isHidden = true
            self.doneButton.alpha = 0
            self.progressLabel.isHidden = true
            self.progressLabel.alpha = 0
            self.horizontalLine2.isHidden = true
            self.horizontalLine2.alpha = 0
            self.day1Button.isHidden = true
            self.day1Button.alpha = 0
            self.day2Button.isHidden = true
            self.day2Button.alpha = 0
            self.day3Button.isHidden = true
            self.day3Button.alpha = 0
            self.workoutPlanTableView.isHidden = true
            self.workoutPlanTableView.alpha = 0
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapDay1Button(){
        //        print("DEBUG PRINT:", "didTapDay1Button")
        
        workoutPlanTableView.reloadData()
        activeButton(uiButton: day1Button)
    }
    
    @objc private func didTapDay2Button(){
        //        print("DEBUG PRINT:", "didTapDay2Button")
        
        workoutPlanTableView.reloadData()
        activeButton(uiButton: day2Button)
    }
    
    @objc private func didTapDay3Button(){
        //        print("DEBUG PRINT:", "didTapDay3Button")
        
        workoutPlanTableView.reloadData()
        activeButton(uiButton: day3Button)
    }
    
    @objc private func didTapPreviousButton(){
        //        print("DEBUG PRINT:", "didTapPreviousButton")
        
        resetTimer()
        exerciseLabel.text = exerciseNameList[nameIndex]
        
        nameIndex = (nameIndex == 0) ? progressLevel : nameIndex - 1
    }
    
    @objc private func didTapStartButton(){
        //        print("DEBUG PRINT:", "didTapStartButton")
        
        if (isStart){
            isStart = false
            stopTimer()
        }
        else{
            isStart = true
            startTimer()
        }
    }
    
    @objc private func didTapNextButton(){
        //        print("DEBUG PRINT:", "didTapNextButton")
        
        resetTimer()
        exerciseLabel.text = exerciseNameList[nameIndex]
        
        nameIndex = (nameIndex == progressLevel) ? 0 : nameIndex + 1
    }
    
    @objc private func didTapDoneiousButton(){
        //        print("DEBUG PRINT:", "didTapDoneiousButton")
     
        resetTimer()
        progress = (progress == exerciseNameList.count) ? progress : progress + 1
        AuthManager.progressLevel = progress
        AuthManager.burnedCal += exerciseBurnedCalList[nameIndex]
        progressLabel.text = "Progress \(progress)/\(exerciseNameList.count)"
    }
    
    private func activeButton(uiButton: UIButton) {
        day1Button.backgroundColor = .tertiaryLabel
        day2Button.backgroundColor = .tertiaryLabel
        day3Button.backgroundColor = .tertiaryLabel
        
        uiButton.backgroundColor = ColorGuide.primary
    }
    
}


// MARK: - UITableView Section
extension WorkoutPlanViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkoutPlanExerciseData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
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
