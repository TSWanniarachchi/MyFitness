//
//  UICollectionViewCell.swift
//  MyFitness
//
//  Created by Sachin on 5/7/23.
//

import UIKit
import QuartzCore

class TargetMusclesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let cellIdentifier = "TargetMusclesCollectionViewCell"
    
    //MARK: - UI Components   
    private let musclesImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
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
        
        self.musclesImageView.image = nil
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
        contentView.addSubview(musclesImageView)
    }
    
    //  MARK: - Setup UI Constraints
    private func setUpConstraints(){
       
        NSLayoutConstraint.activate([
            musclesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            musclesImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            musclesImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            musclesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    //MARK: - Set Up Values
    public func setUpValues(image: String)
    {
        self.musclesImageView.image = UIImage(named: image)
    }
    
}
