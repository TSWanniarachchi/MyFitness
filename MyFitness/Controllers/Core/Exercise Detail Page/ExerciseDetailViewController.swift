//
//  ExerciseDetailViewController.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit

class ExerciseDetailViewController: UIViewController {
    
    //MARK: - Variables
    var ExerciseData = [ExerciseModel]()
    
    //MARK: - UI Components
    private let spinner = CustomSpinner(size: .med,
                                        tintColor: ColorGuide.primary)
    
    private let exerciseImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                    imageType: .page,
                                                    imageLayout: .dark)
    
    private let backButton = CustomImageButton(image: UIImage(systemName: "heart.fill")!,
                                               pointSize: 22,
                                               cornerRadius: 18,
                                               tintColor: .secondarySystemBackground,
                                               backgroundColor: .secondarySystemBackground)
    
    private let addCustomSheduleButton = CustomImageButton(image: UIImage(systemName: "heart.fill")!,
                                                           pointSize: 22,
                                                           cornerRadius: 18,
                                                           tintColor: ColorGuide.primary,
                                                           backgroundColor: .secondarySystemBackground)
    
    private let categoryLabel = CustomLabel(labelType: .header3,
                                            textColor: ColorGuide.primary,
                                            textAlignment: .left)
    
    private let difficultyLevelLabel = CustomLabel(labelType: .header3,
                                                   textColor: .secondaryLabel,
                                                   textAlignment: .right)
    
    private let exerciseNameLabel = CustomLabel(labelType: .header2,
                                                textColor: .label,
                                                textAlignment: .left)
    
    private let equipmentLabel = CustomLabel(labelType: .text1,
                                             textColor: .secondaryLabel,
                                             textAlignment: .left)
    
    private let burnedCaloriesLabel = CustomLabel(labelType: .text1,
                                                  textColor: .label,
                                                  textAlignment: .left)
    
    private let durationLabel = CustomLabel(labelType: .text1,
                                            textColor: .label,
                                            textAlignment: .right)
    
    private let horizontalLine = CustomHorizontalBar(backgroundColor: ColorGuide.secondary)
    
    private let targetMusclesHeaderLabel = CustomLabel(labelType: .header3,
                                                       textColor: .label,
                                                       textAlignment: .left)
    
    private let targetMusclesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TargetMuscleCollectionViewCell.self,
                                forCellWithReuseIdentifier: TargetMuscleCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private let contextHeaderLabel = CustomLabel(labelType: .header3,
                                                 textColor: .label,
                                                 textAlignment: .left)
    
    private let contextLabel = CustomLabel(labelType: .paragraph1,
                                           textColor: ColorGuide.secondary,
                                           textAlignment: .left)
    
    private let descriptionHeaderLabel = CustomLabel(labelType: .header3,
                                                     textColor: .label,
                                                     textAlignment: .left)
    
    private let descriptionLabel = CustomLabel(labelType: .paragraph1,
                                               textColor: ColorGuide.secondary,
                                               textAlignment: .left)
    
    //MARK: - Initialization
    init(exercise: ExerciseModel){
        super.init(nibName: nil, bundle: nil)
        
        ExerciseData = [exercise]
        // print(ExerciseData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubviews()
        setUpConstraints()
        setUpCllectionView()
        setUpValues()
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(spinner)
        view.addSubview(exerciseImageView)
        view.addSubview(backButton)
        view.addSubview(addCustomSheduleButton)
        view.addSubview(categoryLabel)
        view.addSubview(difficultyLevelLabel)
        view.addSubview(exerciseNameLabel)
        view.addSubview(equipmentLabel)
        view.addSubview(burnedCaloriesLabel)
        view.addSubview(durationLabel)
        view.addSubview(horizontalLine)
        view.addSubview(targetMusclesHeaderLabel)
        view.addSubview(targetMusclesCollectionView)
        view.addSubview(contextHeaderLabel)
        view.addSubview(contextLabel)
        view.addSubview(descriptionHeaderLabel)
        view.addSubview(descriptionLabel)
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            exerciseImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            exerciseImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            exerciseImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 320),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 3),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.widthAnchor.constraint(equalToConstant: 80),
            
            addCustomSheduleButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            addCustomSheduleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            addCustomSheduleButton.heightAnchor.constraint(equalToConstant: 40),
            addCustomSheduleButton.widthAnchor.constraint(equalToConstant: 40),
            
            categoryLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 5),
            categoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            difficultyLevelLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 5),
            difficultyLevelLabel.leftAnchor.constraint(equalTo: categoryLabel.rightAnchor, constant: 5),
            difficultyLevelLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            exerciseNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            equipmentLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            equipmentLabel.leftAnchor.constraint(equalTo: exerciseNameLabel.rightAnchor, constant: 5),
            equipmentLabel.bottomAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor),
            
            burnedCaloriesLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 7),
            burnedCaloriesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            durationLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 7),
            durationLabel.leftAnchor.constraint(equalTo: burnedCaloriesLabel.rightAnchor, constant: 5),
            durationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            horizontalLine.topAnchor.constraint(equalTo: burnedCaloriesLabel.bottomAnchor, constant: 7),
            horizontalLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            horizontalLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            
            targetMusclesHeaderLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            targetMusclesHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            targetMusclesHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            targetMusclesCollectionView.topAnchor.constraint(equalTo: targetMusclesHeaderLabel.bottomAnchor, constant: 5),
            targetMusclesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            targetMusclesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            targetMusclesCollectionView.heightAnchor.constraint(equalToConstant: 130),
            
            contextHeaderLabel.topAnchor.constraint(equalTo: targetMusclesCollectionView.bottomAnchor, constant: 3),
            contextHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            contextHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            contextLabel.topAnchor.constraint(equalTo: contextHeaderLabel.bottomAnchor, constant: 2),
            contextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            contextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            descriptionHeaderLabel.topAnchor.constraint(equalTo: contextLabel.bottomAnchor, constant: 5),
            descriptionHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            descriptionHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: 2),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
    }
    
    //  MARK: - Setup CllectionView
    private func setUpCllectionView(){
        targetMusclesCollectionView.delegate = self
        targetMusclesCollectionView.dataSource = self
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        
        if let exercise = ExerciseData.first {
            exerciseImageView.image = UIImage(named: exercise.media.image)
            categoryLabel.text = exercise.category
            switch exercise.difficultyLevel {
            case 1:
                difficultyLevelLabel.text = "⚡️"
            case 2:
                difficultyLevelLabel.text = "⚡️⚡️"
            case 3:
                difficultyLevelLabel.text = "⚡️⚡️⚡️"
            default:
                difficultyLevelLabel.text = ""
            }
            exerciseNameLabel.text = exercise.name
            equipmentLabel.text = "(\(exercise.equipment))"
            burnedCaloriesLabel.addLeading(image: UIImage(systemName: "flame")?.withTintColor(.red) ?? UIImage(),
                                           text: "  \(exercise.burnedCalories) KCal")
            durationLabel.addLeading(image: UIImage(systemName: "clock")?.withTintColor(.systemGreen) ?? UIImage(),
                                     text: "  \(exercise.context.duration / 60) min")
            targetMusclesHeaderLabel.text = "Traget Muscles"
            contextHeaderLabel.text = "Context"
            contextLabel.text = "\(exercise.context.sets) Sets, \(exercise.context.reps) Reps & \((exercise.context.rest ?? 60) / 60) Min rest between sets."
            descriptionHeaderLabel.text = "Description"
            descriptionLabel.text = exercise.description
        }
        
    }
    
}


//MARK: - Collection View Section
extension ExerciseDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let exercise = ExerciseData.first {
            return exercise.targetMuscle.count
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
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TargetMuscleCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? TargetMuscleCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        if let exercise = ExerciseData.first {
            cell.setUpValues(image: exercise.targetMuscle[indexPath.row])
            return cell
        }
        cell.setUpValues(image: "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 50) / 3
        return CGSize(width: width,
                      height: width * 1.0)
    }
    
}
