//
//  CollectionViewCell.swift
//  MyFitness
//
//  Created by Sachin on 5/8/23.
//

import UIKit
import QuartzCore

class ExerciseListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let cellIdentifier = "ExerciseListCollectionViewCell"
    
    //MARK: - UI Components
    private let exerciseImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                    imageType: .collection,
                                                    imageLayout: .light)
    
    private let exerciseNameLabel = CustomLabel(labelType: .header5,
                                                textColor: .label,
                                                textAlignment: .left)
    
    private let equipmentLabel = CustomLabel(labelType: .text3,
                                             textColor: .secondaryLabel,
                                             textAlignment: .left)
    
    private let difficultyLevelLabel = CustomLabel(labelType: .text4,
                                                   textColor: .secondaryLabel,
                                                   textAlignment: .right)
    
    //  MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        
        setUpLayer()
        addSubviews()
        setUpConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.exerciseImageView.image = nil
        self.exerciseNameLabel.text = nil
        self.equipmentLabel.text = nil
        self.difficultyLevelLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Up Layer
    private func setUpLayer(){
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    //  MARK: - Add Subviews to contentView
    private func addSubviews(){
        contentView.addSubview(exerciseImageView)
        contentView.addSubview(exerciseNameLabel)
        contentView.addSubview(equipmentLabel)
        contentView.addSubview(difficultyLevelLabel)
    }
    
    //  MARK: - Setup UI Constraints
    private func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            exerciseImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            exerciseImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 130),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 3),
            exerciseNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            exerciseNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            
            equipmentLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 0),
            equipmentLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            
            difficultyLevelLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 0),
            difficultyLevelLabel.leftAnchor.constraint(equalTo: equipmentLabel.rightAnchor, constant: 10),
            difficultyLevelLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
        ])
        
    }
    
    //MARK: - Set Up Values
    public func setUpValues(exerciseImage: String, exerciseName: String, equipment: String, difficultyLevel: Int)
    {
        self.exerciseImageView.image = UIImage(named: exerciseImage)
        self.exerciseNameLabel.text = exerciseName
        self.equipmentLabel.text = equipment
        switch difficultyLevel {
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
