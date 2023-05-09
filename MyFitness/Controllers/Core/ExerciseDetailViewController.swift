//
//  ExerciseDetailViewController.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit

class ExerciseDetailViewController: UIViewController {
    
    //MARK: - Variables
    
    //MARK: - UI Components
    private let exerciseImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                    imageType: .page,
                                                    imageLayout: .dark)
    
    private let exerciseCategoryLabel = CustomLabel(labelType: .header4,
                                                    textColor: ColorGuide.primary,
                                                textAlignment: .left)
    
    private let exerciseNameLabel = CustomLabel(labelType: .header2,
                                                textColor: .label,
                                                textAlignment: .left)
    
    private let calorieLabel = CustomLabel(labelType: .text1,
                                           textColor: .label,
                                           textAlignment: .left)
    
    private let timeLabel = CustomLabel(labelType: .text1,
                                          textColor: .label,
                                        textAlignment: .left)
    
    private let horizontalLine = CustomHorizontalBar(backgroundColor: ColorGuide.secondary)
    
    private let tragetMusclesHeaderLabel = CustomLabel(labelType: .header3,
                                                        textColor: .label,
                                                        textAlignment: .left)
    
    private let tragetMusclesCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TragetMusclesCollectionViewCell.self,
                                forCellWithReuseIdentifier: TragetMusclesCollectionViewCell.cellIdentifier)
            return collectionView
        }()
    
    private let descriptionHeaderLabel = CustomLabel(labelType: .header3,
                                                     textColor: .label,
                                                     textAlignment: .left)
    
    private let descriptionLabel = CustomLabel(labelType: .paragraph1,
                                               textColor: ColorGuide.secondary,
                                               textAlignment: .left)
    
    private let exerciseHeaderLabel = CustomLabel(labelType: .header3,
                                                     textColor: .label,
                                                     textAlignment: .left)
    
    private let btnBackGroundView = CustomeButtonBackGround(backgroundColor: ColorGuide.secondary)
    
    private let btnBackGroundLabel = CustomLabel(labelType: .text1,
                                                     textColor: .label,
                                                     textAlignment: .left)
    
    private let startWorkoutButton = CustomButton(buttonType: .primary,
                                                title: "Start Workout",
                                                fontsize: .med)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(exerciseImageView)
        view.addSubview(exerciseCategoryLabel)
        view.addSubview(exerciseNameLabel)
        view.addSubview(calorieLabel)
        view.addSubview(timeLabel)
        view.addSubview(horizontalLine)
        view.addSubview(tragetMusclesHeaderLabel)
        view.addSubview(tragetMusclesCollectionView)
        view.addSubview(descriptionHeaderLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(exerciseHeaderLabel)
        view.addSubview(btnBackGroundView)
        view.addSubview(btnBackGroundLabel)
        view.addSubview(startWorkoutButton)
        //title = "Dats"

        setUpCllectionView()
        setUpConstraints()
        setUpValues()
        
        //addFavariouteButton.addTarget(self, action: #selector(didTapAddFavarioute), for: .touchUpInside)
    }
    
    //  MARK: - Setup UI Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: view.topAnchor),
            exerciseImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            exerciseImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 320),
            
            exerciseCategoryLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 15),
            exerciseCategoryLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            exerciseCategoryLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            exerciseCategoryLabel.heightAnchor.constraint(equalToConstant: 25),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: exerciseCategoryLabel.bottomAnchor, constant: 2),
            exerciseNameLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            exerciseNameLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            exerciseNameLabel.heightAnchor.constraint(equalToConstant: 28),
            
            calorieLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 10),
            calorieLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            calorieLabel.heightAnchor.constraint(equalToConstant: 25),
            
            timeLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 25),
            
            horizontalLine.topAnchor.constraint(equalTo: calorieLabel.bottomAnchor, constant: 5),
            horizontalLine.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            horizontalLine.widthAnchor.constraint(equalToConstant: view.bounds.width - 30),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            
            tragetMusclesHeaderLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            tragetMusclesHeaderLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            tragetMusclesHeaderLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            tragetMusclesHeaderLabel.heightAnchor.constraint(equalToConstant: 25),
            
            tragetMusclesCollectionView.topAnchor.constraint(equalTo: tragetMusclesHeaderLabel.bottomAnchor, constant: 10),
            tragetMusclesCollectionView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            tragetMusclesCollectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            tragetMusclesCollectionView.heightAnchor.constraint(equalToConstant: 125),
            
            descriptionHeaderLabel.topAnchor.constraint(equalTo: tragetMusclesCollectionView.bottomAnchor, constant: 10),
            descriptionHeaderLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            descriptionHeaderLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            descriptionHeaderLabel.heightAnchor.constraint(equalToConstant: 25),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: 5),
            descriptionLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            
            exerciseHeaderLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            exerciseHeaderLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            exerciseHeaderLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            exerciseHeaderLabel.heightAnchor.constraint(equalToConstant: 25),
            
            btnBackGroundView.topAnchor.constraint(equalTo: exerciseHeaderLabel.bottomAnchor, constant: 10),
            btnBackGroundView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            btnBackGroundView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            btnBackGroundView.heightAnchor.constraint(equalToConstant: 56),
            
            btnBackGroundLabel.centerYAnchor.constraint(equalTo: btnBackGroundView.centerYAnchor),
            btnBackGroundLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 15),
            
            startWorkoutButton.centerYAnchor.constraint(equalTo: btnBackGroundView.centerYAnchor),
            startWorkoutButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 135),
            startWorkoutButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -17),
            startWorkoutButton.heightAnchor.constraint(equalToConstant: 42),
        ])
        
//                btnBackGroundLabel.backgroundColor = .blue
        //        exerciseCategoryLabel.backgroundColor = .blue
    }
    
    private func setUpCllectionView(){
        tragetMusclesCollectionView.delegate = self
        tragetMusclesCollectionView.dataSource = self
        }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        
        exerciseImageView.image = UIImage(named: "E1")
        exerciseCategoryLabel.text = "Warm Up"
        exerciseNameLabel.text = "Beginner Crunchers Jacks"
        self.calorieLabel.addLeading(image: UIImage(systemName: "flame")?.withTintColor(.red) ?? UIImage(),
                                     text: "  \("320") KCal")
        self.timeLabel.addLeading(image: UIImage(systemName: "clock")?.withTintColor(.systemGreen) ?? UIImage(),
                                  text: "  \("10") min")
        self.tragetMusclesHeaderLabel.text = "Traget Muscles"
        self.descriptionHeaderLabel.text = "Description"
        self.descriptionLabel.text = "10 min, 2 Sets, 30 sec rest between sets."
        self.exerciseHeaderLabel.text = "Exercise"
        self.btnBackGroundLabel.text = "Free Plan"
        
    }
    
}

//MARK: - Collection View Section
extension ExerciseDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TragetMusclesCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? TragetMusclesCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        cell.setUpValues(title: "Key", value: "Value")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 60) / 3
        return CGSize(width: width,
                      height: width * 1.1)
    }
    
}

