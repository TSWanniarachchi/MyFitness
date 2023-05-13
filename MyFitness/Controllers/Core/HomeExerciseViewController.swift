//
//  ExerciseDetailViewController.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Variables
    var HomeWorkoutPlan = ["Stay in Shape", "Immunity Booster", "Bumbbell", "Band"]
    var ExerciseData = [ExerciseModel]()
    
    //MARK: - UI Components
    private let spinner = CustomSpinner(size: .med,
                                        tintColor: ColorGuide.primary)
    
    private let userProfileImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                       imageType: .avatar,
                                                       imageLayout: .light)
    
    private let welcomeLabel = CustomLabel(labelType: .text1,
                                           textColor: .secondaryLabel,
                                           textAlignment: .left)
    
    private let usernameLabel = CustomLabel(labelType: .header3,
                                            textColor: .label,
                                            textAlignment: .left)
    
    private let stepLabel = CustomLabel(labelType: .card,
                                        textColor: .label,
                                        textAlignment: .center)
    
    private let calorieBurnLabel = CustomLabel(labelType: .card,
                                               textColor: .label,
                                               textAlignment: .center)
    
    private let progressLabel = CustomLabel(labelType: .card,
                                            textColor: .label,
                                            textAlignment: .center)
    
    private let summaryChartLabel = CustomLabel(labelType: .card,
                                                textColor: .label,
                                                textAlignment: .center)
    
    private let category1Button = CustomButton(buttonType: .primary,
                                               title: "Chest",
                                               fontsize: .med)
    
    private let category2Button = CustomButton(buttonType: .secondary,
                                               title: "ABS",
                                               fontsize: .med)
    
    private let category3Button = CustomButton(buttonType: .secondary,
                                               title: "Arm",
                                               fontsize: .med)
    
    private let category4Button = CustomButton(buttonType: .secondary,
                                               title: "Leg",
                                               fontsize: .med)
    
    private let sectionHeader1 = CustomLabel(labelType: .header3,
                                             textColor: .label,
                                             textAlignment: .left)
    
    private let exerciseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ExerciseListCollectionViewCell.self,
                                forCellWithReuseIdentifier: ExerciseListCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private let sectionHeader2 = CustomLabel(labelType: .header3,
                                             textColor: .label,
                                             textAlignment: .left)
    
    private let workoutCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeWorkoutPlanCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeWorkoutPlanCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private let scrollViewLabel = CustomLabel(labelType: .text1,
                                              textColor: .systemBackground,
                                              textAlignment: .left)
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView : UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .never
        let notificationButton = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .done,
            target: self,
            action: #selector(didTapNotification)
        )
        notificationButton.tintColor = ColorGuide.primary
        navigationItem.rightBarButtonItem = notificationButton
        
        setupScrollView()
        addSubviews()
        setUpConstraints()
        setUpCllectionView()
        setUpValues()
        
        category1Button.addTarget(self, action: #selector(didTapCategory1Button), for: .touchUpInside)
        category2Button.addTarget(self, action: #selector(didTapCategory2Button), for: .touchUpInside)
        category3Button.addTarget(self, action: #selector(didTapCategory3Button), for: .touchUpInside)
        category4Button.addTarget(self, action: #selector(didTapCategory4Button), for: .touchUpInside)
    }
    
    //MARK: - SetUp ScrollView
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        contentView.addSubview(spinner)
        contentView.addSubview(userProfileImageView)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(stepLabel)
        contentView.addSubview(calorieBurnLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(summaryChartLabel)
        contentView.addSubview(category1Button)
        contentView.addSubview(category2Button)
        contentView.addSubview(category3Button)
        contentView.addSubview(category4Button)
        contentView.addSubview(sectionHeader1)
        contentView.addSubview(exerciseCollectionView)
        contentView.addSubview(sectionHeader2)
        contentView.addSubview(workoutCollectionView)
        contentView.addSubview(scrollViewLabel)
    }
    
    //  MARK: - UI Setup Constraints
    func setUpConstraints(){
        spinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        userProfileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -35).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -22).isActive = true
        welcomeLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        welcomeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 15).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        stepLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20).isActive = true
        stepLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        stepLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        stepLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        calorieBurnLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20).isActive = true
        calorieBurnLabel.leftAnchor.constraint(equalTo: stepLabel.rightAnchor, constant: 5).isActive = true
        calorieBurnLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        calorieBurnLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        progressLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20).isActive = true
        progressLabel.leftAnchor.constraint(equalTo: calorieBurnLabel.rightAnchor, constant: 5).isActive = true
        progressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        progressLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        summaryChartLabel.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8).isActive = true
        summaryChartLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        summaryChartLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        summaryChartLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        sectionHeader1.topAnchor.constraint(equalTo: summaryChartLabel.bottomAnchor, constant: 10).isActive = true
        sectionHeader1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        sectionHeader1.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        category1Button.topAnchor.constraint(equalTo: sectionHeader1.bottomAnchor, constant: 10).isActive = true
        category1Button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        category1Button.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        category2Button.topAnchor.constraint(equalTo: sectionHeader1.bottomAnchor, constant: 10).isActive = true
        category2Button.leftAnchor.constraint(equalTo: category1Button.rightAnchor, constant: 10).isActive = true
        category2Button.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        category3Button.topAnchor.constraint(equalTo: sectionHeader1.bottomAnchor, constant: 10).isActive = true
        category3Button.leftAnchor.constraint(equalTo: category2Button.rightAnchor, constant: 10).isActive = true
        category3Button.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        category4Button.topAnchor.constraint(equalTo: sectionHeader1.bottomAnchor, constant: 10).isActive = true
        category4Button.leftAnchor.constraint(equalTo: category3Button.rightAnchor, constant: 10).isActive = true
        category4Button.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        exerciseCollectionView.topAnchor.constraint(equalTo: category1Button.bottomAnchor, constant: 10).isActive = true
        exerciseCollectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        exerciseCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 00.98).isActive = true
        exerciseCollectionView.heightAnchor.constraint(equalToConstant: 580).isActive = true
        
        sectionHeader2.topAnchor.constraint(equalTo: exerciseCollectionView.bottomAnchor, constant: 10).isActive = true
        sectionHeader2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        sectionHeader2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        workoutCollectionView.topAnchor.constraint(equalTo: sectionHeader2.bottomAnchor, constant: 10).isActive = true
        workoutCollectionView.heightAnchor.constraint(equalToConstant: 148).isActive = true
        workoutCollectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        workoutCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 00.98).isActive = true
        
        scrollViewLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        scrollViewLabel.topAnchor.constraint(equalTo: workoutCollectionView.bottomAnchor, constant: 0).isActive = true
        scrollViewLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        scrollViewLabel.heightAnchor.constraint(equalToConstant: 3).isActive = true
        scrollViewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    //  MARK: - Setup CllectionView
    private func setUpCllectionView(){
        exerciseCollectionView.delegate = self
        exerciseCollectionView.dataSource = self
        
        workoutCollectionView.delegate = self
        workoutCollectionView.dataSource = self
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        userProfileImageView.image = UIImage(named: "avatar")
        welcomeLabel.text = "WELCOME BACK 👋"
        usernameLabel.text = "MICHALE BERNANDO"
        stepLabel.text = "Steps 12"
        calorieBurnLabel.text = "CAL 456"
        progressLabel.text = "7/12"
        summaryChartLabel.text = "Summary Bar Chart"
        sectionHeader1.text = "Exercise List"
        sectionHeader2.text = "Home Workout Plans"
                
        visibleComponents(isVisible: false)
        fetchExerciseData(category: category1Button.title(for: .normal)!)
    }
    
    // Fetching Data from API Call
    private func fetchExerciseData(category: String) {

        // Create API request
        let request = Request(endpoint: .exercises,
                              pathComponents: ["category", category])
        
        // Call API request & get response
        APICaller.shared.getExercises(URL: request.url) { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let model):

                    self.ExerciseData = model
                    self.exerciseCollectionView.reloadData()
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
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                self.spinner.stopAnimating()
                self.exerciseCollectionView.isHidden = false
                UIView.animate(withDuration: 0.4){
                    self.exerciseCollectionView.alpha = 1
                }
            })
        }
        else {
            spinner.startAnimating()
            self.exerciseCollectionView.isHidden = true
            self.exerciseCollectionView.alpha = 0
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapNotification(){
        print("DEBUG PRINT:", "didTapNotification")
    }
    
    @objc private func didTapCategory1Button(){
        activeButton(uiButton: category1Button)
        print("DEBUG PRINT:", "didTapCategory1Button")
        
        fetchExerciseData(category: category1Button.title(for: .normal)!)
    }
    
    @objc private func didTapCategory2Button() {
        activeButton(uiButton: category2Button)
        print("DEBUG PRINT:", "didTapCategory2Button")
        
        fetchExerciseData(category: category2Button.title(for: .normal)!)
    }
    
    @objc private func didTapCategory3Button() {
        activeButton(uiButton: category3Button)
        print("DEBUG PRINT:", "didTapCategory3Button")
        
        fetchExerciseData(category: category3Button.title(for: .normal)!)
    }
    
    @objc private func didTapCategory4Button() {
        activeButton(uiButton: category4Button)
        print("DEBUG PRINT:", "didTapCategory4Button")
        
        fetchExerciseData(category: category4Button.title(for: .normal)!)
    }
    
    private func activeButton(uiButton: UIButton) {
        category1Button.backgroundColor = .tertiaryLabel
        category2Button.backgroundColor = .tertiaryLabel
        category3Button.backgroundColor = .tertiaryLabel
        category4Button.backgroundColor = .tertiaryLabel
        
        uiButton.backgroundColor = ColorGuide.primary
    }
    
}


//MARK: - Collection View Section
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exerciseCollectionView {
            return ExerciseData.count
        } else if collectionView == workoutCollectionView {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0 // verticalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0 // horizontalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exerciseCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExerciseListCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? ExerciseListCollectionViewCell else {
                fatalError("Unsupported Cell")
            }
            cell.setUpValues(exercise: ExerciseData[indexPath.row])
            return cell
        } else if collectionView == workoutCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeWorkoutPlanCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? HomeWorkoutPlanCollectionViewCell else {
                fatalError("Unsupported Cell")
            }
            cell.setUpValues(exerciseImage: HomeWorkoutPlan[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == exerciseCollectionView {
            let bounds = UIScreen.main.bounds
            let width = (bounds.width - 35) / 2
            return CGSize(width: width, height: width * 1.0)
        } else if collectionView == workoutCollectionView {
            let bounds = UIScreen.main.bounds
            let width = (bounds.width - 50)
            return CGSize(width: width, height: width * 0.4)
        }
        
        // Default size
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedExercise =  ExerciseData[indexPath.row]
        let detailVC = ExerciseDetailViewController(exercise: selectedExercise)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
