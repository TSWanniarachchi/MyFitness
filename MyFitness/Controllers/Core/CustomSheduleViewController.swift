//
//  CustomSheduleViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/13/23.
//

import UIKit

class CustomSheduleViewController: UIViewController {
    
    //MARK: - Variables
    var ExerciseData = [ExerciseModel]()
    
    //MARK: - UI Components
    private let spinner = CustomSpinner(size: .med,
                                        tintColor: ColorGuide.primary)
    
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
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
        
    }
    
    //  MARK: - Setup CllectionView
    private func setUpCllectionView(){
       
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        
    }
    
}
