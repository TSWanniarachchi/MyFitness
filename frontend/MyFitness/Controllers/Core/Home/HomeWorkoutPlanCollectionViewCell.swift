//
//  HomeWorkoutPlanCollectionViewCell.swift
//  MyFitness
//
//  Created by Sachin on 5/10/23.
//

import UIKit

class HomeWorkoutPlanCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let cellIdentifier = "HomeWorkoutPlanCollectionViewCell"
    
    //MARK: - UI Components
    private let workoutImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                    imageType: .collection,
                                                    imageLayout: .light)

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
        self.workoutImageView.image = nil
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
        contentView.addSubview(workoutImageView)
    }
    
    //  MARK: - Setup UI Constraints
    private func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            workoutImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            workoutImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            workoutImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    //MARK: - Set Up Values
    public func setUpValues(exerciseImage: String)
    {
        self.workoutImageView.image = UIImage(named: exerciseImage)
    }
    
}
