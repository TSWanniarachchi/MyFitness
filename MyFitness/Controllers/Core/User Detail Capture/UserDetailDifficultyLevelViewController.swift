//
//  UserDetailDifficultyLevelViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class UserDetailDifficultyLevelViewController: UIViewController {
    
    //MARK: - UI Components
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let descriptionLabel = CustomLabel(labelType: .paragraph1,
                                                   textColor: .label,
                                                   textAlignment: .center)
    
    private let beginnerOptionButton = CustomButton(buttonType: .secondary,
                                          title: "⚡️ Beginner",
                                          fontsize: .option)
    
    private let intermediateOptionButton = CustomButton(buttonType: .secondary,
                                          title: "⚡️⚡️ Intermediate",
                                          fontsize: .option)
    
    private let advancedOptionButton = CustomButton(buttonType: .secondary,
                                          title: "⚡️⚡️⚡️ Advanced",
                                          fontsize: .option)
    
    private let nextButton = CustomButton(buttonType: .primary,
                                          title: "Next",
                                          fontsize: .big)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubviews()
        setUpConstraints()
        setUpValues()
        
        beginnerOptionButton.addTarget(self, action: #selector(didTapBeginnerOptionButton), for: .touchUpInside)
        intermediateOptionButton.addTarget(self, action: #selector(didTapIntermediateOptionButton), for: .touchUpInside)
        advancedOptionButton.addTarget(self, action: #selector(didTapAdvancedOptionButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(beginnerOptionButton)
        view.addSubview(intermediateOptionButton)
        view.addSubview(advancedOptionButton)
        view.addSubview(nextButton)
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 25),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            beginnerOptionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 45),
            beginnerOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            beginnerOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            beginnerOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            intermediateOptionButton.topAnchor.constraint(equalTo: beginnerOptionButton.bottomAnchor, constant: 10),
            intermediateOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            intermediateOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            intermediateOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            advancedOptionButton.topAnchor.constraint(equalTo: intermediateOptionButton.bottomAnchor, constant: 10),
            advancedOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            advancedOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            advancedOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        headerLabel.text = "What's Your Difficulty \nLevel?"
        descriptionLabel.text = "Your coach will design your \nworkouts that best suit your \ndifficulty level"
    }
    
    // MARK: - Selectors
    @objc private func didTapBeginnerOptionButton(){
        //        print("DEBUG PRINT:", "didTapBeginnerOptionButton")
        
        selectedOption(uiButton: beginnerOptionButton)
        AuthManager.difficultyLevel = 1
    }
    
    @objc private func didTapIntermediateOptionButton(){
        //        print("DEBUG PRINT:", "didTapIntermediateOptionButton")
        
        selectedOption(uiButton: intermediateOptionButton)
        AuthManager.difficultyLevel = 2
    }
    
    @objc private func didTapAdvancedOptionButton(){
        //        print("DEBUG PRINT:", "didTapAdvancedOptionButton")
        
        selectedOption(uiButton: advancedOptionButton)
        AuthManager.difficultyLevel = 3
    }
    
    @objc private func didTapNextButton(){
        //        print("DEBUG PRINT:", "didTapNextButton")
        
        if !(AuthManager.difficultyLevel == 0) {
            let vc = TabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alert",
                                          message: "Please select a difficulty level.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func selectedOption(uiButton: UIButton) {
        beginnerOptionButton.backgroundColor = .tertiaryLabel
        intermediateOptionButton.backgroundColor = .tertiaryLabel
        advancedOptionButton.backgroundColor = .tertiaryLabel
  
        uiButton.backgroundColor = ColorGuide.primary
    }

}
