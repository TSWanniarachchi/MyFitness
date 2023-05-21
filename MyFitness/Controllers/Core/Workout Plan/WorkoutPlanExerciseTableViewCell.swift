//
//  TableViewCell.swift
//  MyFitness
//
//  Created by Sachin on 5/17/23.
//

import UIKit

class WorkoutPlanExerciseTableViewCell: UITableViewCell {
    
    //MARK: - Variables
    static let identifier = "WorkoutPlanExerciseTableViewCell"
    
    //MARK: - UI Components
    private let exerciseImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                    imageType: .table,
                                                    imageLayout: .light)
    
    private let exerciseNameLabel = CustomLabel(labelType: .header3,
                                                textColor: .label,
                                                textAlignment: .left)
    
    private let contextLabel = CustomLabel(labelType: .text1,
                                                 textColor: .secondaryLabel,
                                                 textAlignment: .left)
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpLayer()
        addSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Set Up Layer
    private func setUpLayer(){
        contentView.backgroundColor = .systemBackground
    }
    
    //  MARK: - Add Subviews to contentView
    private func addSubviews(){
        contentView.addSubview(exerciseImageView)
        contentView.addSubview(exerciseNameLabel)
        contentView.addSubview(contextLabel)
    }
    
    //  MARK: - Setup UI Constraints
    private func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            exerciseImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            exerciseImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            exerciseImageView.widthAnchor.constraint(equalToConstant: 120),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 2),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                  
            contextLabel.leadingAnchor.constraint(equalTo: self.exerciseImageView.trailingAnchor, constant: 10),
            contextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            contextLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor, constant: -5),
        ])
        
    }
    
    //MARK: - Set Up Values
    public func setUpValues(workoutPlanExercise: ExerciseModel)
    {
        exerciseImageView.image = UIImage(named: workoutPlanExercise.media.image)
        let exerciseNameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        let equipmentAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor.label
        ]
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: workoutPlanExercise.name, attributes: exerciseNameAttributes))
        attributedText.append(NSAttributedString(string: " (\(workoutPlanExercise.equipment))", attributes: equipmentAttributes))
        exerciseNameLabel.attributedText = attributedText
        contextLabel.text = "\(workoutPlanExercise.context.sets) Sets, \(workoutPlanExercise.context.reps) Reps & \((workoutPlanExercise.context.rest ?? 60) / 60) Min Rest"
    }

}
