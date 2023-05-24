//
//  UserDetailFitnessGoalViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class UserDetailFitnessGoalViewController: UIViewController {
    
    //MARK: - UI Components
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let descriptionLabel = CustomLabel(labelType: .paragraph1,
                                               textColor: .label,
                                               textAlignment: .center)
    
    private let buildMuscleOptionButton = CustomButton(buttonType: .secondary,
                                                       title: "💪 Build Muscle",
                                                       fontsize: .option)
    
    private let loseWeightOptionButton = CustomButton(buttonType: .secondary,
                                                      title: "🏋️‍♀️ Lose Weight",
                                                      fontsize: .option)
    
    private let improveEnduranceOptionButton = CustomButton(buttonType: .secondary,
                                                            title: "🏃‍♂️ Improve Endurance",
                                                            fontsize: .option)
    
    private let gainStrengthOptionButton = CustomButton(buttonType: .secondary,
                                                        title: "💥 Gain Strength",
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
        
        buildMuscleOptionButton.addTarget(self, action: #selector(didTapBuildMuscleOptionButton), for: .touchUpInside)
        loseWeightOptionButton.addTarget(self, action: #selector(didTapLoseWeightOptionButton), for: .touchUpInside)
        improveEnduranceOptionButton.addTarget(self, action: #selector(didTapImproveEnduranceOptionButton), for: .touchUpInside)
        gainStrengthOptionButton.addTarget(self, action: #selector(didTapGainStrengthOptionButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(buildMuscleOptionButton)
        view.addSubview(loseWeightOptionButton)
        view.addSubview(improveEnduranceOptionButton)
        view.addSubview(gainStrengthOptionButton)
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
            
            buildMuscleOptionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 45),
            buildMuscleOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            buildMuscleOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            buildMuscleOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            loseWeightOptionButton.topAnchor.constraint(equalTo: buildMuscleOptionButton.bottomAnchor, constant: 10),
            loseWeightOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            loseWeightOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            loseWeightOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            improveEnduranceOptionButton.topAnchor.constraint(equalTo: loseWeightOptionButton.bottomAnchor, constant: 10),
            improveEnduranceOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            improveEnduranceOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            improveEnduranceOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            gainStrengthOptionButton.topAnchor.constraint(equalTo: improveEnduranceOptionButton.bottomAnchor, constant: 10),
            gainStrengthOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            gainStrengthOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            gainStrengthOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        headerLabel.text = "What's Your Goal?"
        descriptionLabel.text = "Your coach will design your \nworkouts that best suit your \ngoal"
    }
    
    // MARK: - Selectors
    @objc private func didTapBuildMuscleOptionButton(){
        //        print("DEBUG PRINT:", "didTapBuildMuscleOptionButton")
        
        selectedOption(uiButton: buildMuscleOptionButton)
        AuthManager.fitnessGoal = "Build Muscle"
    }
    
    @objc private func didTapLoseWeightOptionButton(){
        //        print("DEBUG PRINT:", "didTapLoseWeightOptionButton")
        
        selectedOption(uiButton: loseWeightOptionButton)
        AuthManager.fitnessGoal = "Lose Weight"
    }
    
    @objc private func didTapImproveEnduranceOptionButton(){
        //        print("DEBUG PRINT:", "didTapImproveEnduranceOptionButton")
        
        selectedOption(uiButton: improveEnduranceOptionButton)
        AuthManager.fitnessGoal = "Improve Endurance"
    }
    
    @objc private func didTapGainStrengthOptionButton(){
        //        print("DEBUG PRINT:", "didTapGainStrengthOptionButton")
        
        selectedOption(uiButton: gainStrengthOptionButton)
        AuthManager.fitnessGoal = "Gain Strength"
    }
    
    @objc private func didTapNextButton(){
        //        print("DEBUG PRINT:", "didTapNextButton")
        
        if !(AuthManager.fitnessGoal == "") {
            let vc = UserDetailDifficultyLevelViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            //        let vc = UserDetailDifficultyLevelViewController()
            //        vc.modalPresentationStyle = .fullScreen
            //        self.present(vc, animated: false, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alert",
                                          message: "Please select a fitness goal.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func selectedOption(uiButton: UIButton) {
        buildMuscleOptionButton.backgroundColor = .tertiaryLabel
        loseWeightOptionButton.backgroundColor = .tertiaryLabel
        improveEnduranceOptionButton.backgroundColor = .tertiaryLabel
        gainStrengthOptionButton.backgroundColor = .tertiaryLabel
        
        uiButton.backgroundColor = ColorGuide.primary
    }
    
}
