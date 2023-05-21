//
//  ExerciseDetailViewController.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit
import AVFoundation
import AVKit

class ExerciseDetailViewController: UIViewController {
    
    //MARK: - Variables
    var ExerciseData = [ExerciseModel]()
    var ResponseData = [ResponseModel]()
    var ExerciseId = ""
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer?
    
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
    
    private let addCustomSheduleButton = CustomImageButton(image: UIImage(systemName: "bookmark.fill")!,
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
    
    private let videoPlayButton = CustomImageButton(image: UIImage(systemName: "play.fill")!,
                                                    pointSize: 30,
                                                    cornerRadius: 26,
                                                    tintColor: ColorGuide.primary,
                                                    backgroundColor: .secondarySystemBackground)
    
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
        
        addCustomSheduleButton.addTarget(self, action: #selector(didTapAddCustomSheduleButton), for: .touchUpInside)
        videoPlayButton.addTarget(self, action: #selector(didTapPlayViedoButton), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        view.addSubview(videoPlayButton)
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
            
            addCustomSheduleButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            addCustomSheduleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            addCustomSheduleButton.heightAnchor.constraint(equalToConstant: 45),
            addCustomSheduleButton.widthAnchor.constraint(equalToConstant: 40),
            
            categoryLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 5),
            categoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            videoPlayButton.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 10),
            videoPlayButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            videoPlayButton.heightAnchor.constraint(equalToConstant: 52),
            videoPlayButton.widthAnchor.constraint(equalToConstant: 52),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            exerciseNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            equipmentLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            equipmentLabel.leftAnchor.constraint(equalTo: exerciseNameLabel.rightAnchor, constant: 5),
            equipmentLabel.bottomAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor),
            
            durationLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 7),
            durationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            difficultyLevelLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 7),
            difficultyLevelLabel.leftAnchor.constraint(equalTo: durationLabel.rightAnchor, constant: 5),
            difficultyLevelLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            horizontalLine.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 7),
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
            ExerciseId = exercise.id
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
            durationLabel.addLeading(image: UIImage(systemName: "clock")?.withTintColor(.systemGreen) ?? UIImage(),
                                     text: "  \(exercise.context.duration / 60) min")
            targetMusclesHeaderLabel.text = "Traget Muscles"
            contextHeaderLabel.text = "Context"
            contextLabel.text = "\(exercise.context.sets) Sets, \(exercise.context.reps) Reps & \((exercise.context.rest ?? 60) / 60) Min rest between sets."
            descriptionHeaderLabel.text = "Description"
            descriptionLabel.text = exercise.description
            
            // Video player
            let urlPathString:String? = Bundle.main.path(forResource: exercise.media.video, ofType: "mp4")
            if let urlPath = urlPathString {
                let videoUrl = NSURL(fileURLWithPath: urlPath)
                
                self.avPlayer = AVPlayer(url: videoUrl as URL)
                self.avPlayerViewController.player = self.avPlayer
            }
        }
        
    }
    
    // MARK: - Selectors
    @objc private func didTapPlayViedoButton(){
        //        print("DEBUG PRINT:", "didTapPlayViedoButton")
        
        self.present(self.avPlayerViewController, animated: true) {
            self.avPlayerViewController.player?.play()
        }
    }
    
    @objc private func didTapAddCustomSheduleButton(){
        //        print("DEBUG PRINT:", "didTapAddCustomSheduleButton")
        
        insertCustomScheduleExercisesData(userId: "sachin", exerciseId: ExerciseId)
    }
    
    // Insert Data API Call
    private func insertCustomScheduleExercisesData(userId: String, exerciseId: String) {
        
        // Create API request
        let request = Request(endpoint: .customSchedules)
        //        print(request.url)
        
        // Create API request body
        let requestBody: [String: AnyHashable] = [
            "userId": userId,
            "exerciseId": exerciseId
        ]
        
        // Call API request & get response
        APICaller.shared.insertCustomSchedules(URL: request.url, requestBody: requestBody) {
            result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let model):
                    
                    self.ResponseData = model
                    
                    if(self.ResponseData[0].success == true){
                        let alert = UIAlertController(title: "Alert",
                                                      message: String(describing: self.ResponseData[0].message),
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
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .default,
                                                      handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                case .failure(let error):
                    
                    let alert = UIAlertController(title: "Error",
                                                  message: String(describing: error),
                                                  preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .default,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } // end switch
                
            } // end DispatchQueue
            
        }// end APICaller
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
