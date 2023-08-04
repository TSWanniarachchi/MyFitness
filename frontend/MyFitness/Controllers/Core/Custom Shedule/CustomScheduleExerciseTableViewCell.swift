//
//  TableViewCell.swift
//  MyFitness
//
//  Created by Sachin on 5/14/23.
//

import UIKit

class CustomScheduleExerciseTableViewCell: UITableViewCell {
    
    //MARK: - Variables
    static let identifier = "CustomScheduleExerciseTableViewCell"
    
    //MARK: - UI Components
    private let exerciseImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                    imageType: .table,
                                                    imageLayout: .light)
    
    private let exerciseNameLabel = CustomLabel(labelType: .header3,
                                                textColor: .label,
                                                textAlignment: .left)
    
    private let categoryLabel = CustomLabel(labelType: .header5,
                                            textColor: ColorGuide.primary,
                                            textAlignment: .left)
    
    private let difficultyLevelLabel = CustomLabel(labelType: .text1,
                                                   textColor: .secondaryLabel,
                                                   textAlignment: .right)
    
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
    
    //MARK: - Set Up Layer
    private func setUpLayer(){
        contentView.backgroundColor = .systemBackground
    }
    
    //  MARK: - Add Subviews to contentView
    private func addSubviews(){
        contentView.addSubview(exerciseImageView)
        contentView.addSubview(exerciseNameLabel)
        contentView.addSubview(contextLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(difficultyLevelLabel)
    }
    
    //  MARK: - Setup UI Constraints
    private func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            exerciseImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            exerciseImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            exerciseImageView.widthAnchor.constraint(equalToConstant: 145),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor ,constant: 1),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                        
            categoryLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            categoryLabel.bottomAnchor.constraint(equalTo: contextLabel.topAnchor ,constant: -5),
            
            contextLabel.leadingAnchor.constraint(equalTo: self.exerciseImageView.trailingAnchor, constant: 10),
            contextLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
 
            difficultyLevelLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: 10),
            difficultyLevelLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
        ])
        
    }
    
    //MARK: - Set Up Values
    public func setUpValues(customScheduleExercise: ExerciseModel)
    {
        exerciseImageView.image = UIImage(named: customScheduleExercise.media.image)
        let exerciseNameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        let equipmentAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor.label
        ]
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: customScheduleExercise.name, attributes: exerciseNameAttributes))
        attributedText.append(NSAttributedString(string: " (\(customScheduleExercise.equipment))", attributes: equipmentAttributes))
        exerciseNameLabel.attributedText = attributedText
        categoryLabel.text = customScheduleExercise.category
        contextLabel.text = "\(customScheduleExercise.context.sets) Sets, \(customScheduleExercise.context.reps) Reps"
        switch customScheduleExercise.difficultyLevel {
        case 1:
            difficultyLevelLabel.text = "⚡️"
        case 2:
            difficultyLevelLabel.text = "⚡️⚡️"
        case 3:
            difficultyLevelLabel.text = "⚡️⚡️⚡️"
        default:
            difficultyLevelLabel.text = ""
        }
    }

}
