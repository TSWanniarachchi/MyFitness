//
//  UserDetailFitnessGoalViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class UserDetailFitnessGoalViewController: UIViewController {
    
    //MARK: - Variables
    var fitnessGoalList = ["Build Muscle", "Lose Weight", "Improve Endurance", "Maintain Fitness", "Gain Strength"]

    //MARK: - UI Components
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let descriptionLabel = CustomLabel(labelType: .paragraph1,
                                                   textColor: .label,
                                                   textAlignment: .center)
    
    private let option1Button = CustomButton(buttonType: .secondary,
                                          title: "💪 Build Muscle",
                                          fontsize: .option)
    
    private let option2Button = CustomButton(buttonType: .secondary,
                                          title: "🏋️‍♀️ Lose Weight",
                                          fontsize: .option)
    
    private let option3Button = CustomButton(buttonType: .secondary,
                                          title: "🏃‍♂️ Improve Endurance",
                                          fontsize: .option)
    
    private let option4Button = CustomButton(buttonType: .secondary,
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
        
        option1Button.addTarget(self, action: #selector(didTapoption1Button), for: .touchUpInside)
        option2Button.addTarget(self, action: #selector(didTapoption2Button), for: .touchUpInside)
        option3Button.addTarget(self, action: #selector(didTapoption3Button), for: .touchUpInside)
        option4Button.addTarget(self, action: #selector(didTapoption4Button), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(option1Button)
        view.addSubview(option2Button)
        view.addSubview(option3Button)
        view.addSubview(option4Button)
        view.addSubview(nextButton)
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 25),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            option1Button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 45),
            option1Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            option1Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            option1Button.heightAnchor.constraint(equalToConstant: 65),
            
            option2Button.topAnchor.constraint(equalTo: option1Button.bottomAnchor, constant: 10),
            option2Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            option2Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            option2Button.heightAnchor.constraint(equalToConstant: 65),
            
            option3Button.topAnchor.constraint(equalTo: option2Button.bottomAnchor, constant: 10),
            option3Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            option3Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            option3Button.heightAnchor.constraint(equalToConstant: 65),
            
            option4Button.topAnchor.constraint(equalTo: option3Button.bottomAnchor, constant: 10),
            option4Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            option4Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            option4Button.heightAnchor.constraint(equalToConstant: 65),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        headerLabel.text = "What's Your goal?"
        descriptionLabel.text = "Your coach will design your \nworkouts that best suit your \ngoal"
    }
    
    // MARK: - Selectors
    @objc private func didTapoption1Button(){
        print("DEBUG PRINT:", "didTapoption1Button")
        
        selectedOption(uiButton: option1Button)
    }
    
    @objc private func didTapoption2Button(){
        print("DEBUG PRINT:", "didTapoption2Button")
        
        selectedOption(uiButton: option2Button)
    }
    
    @objc private func didTapoption3Button(){
        print("DEBUG PRINT:", "didTapoption3Button")
        
        selectedOption(uiButton: option3Button)
    }
    
    @objc private func didTapoption4Button(){
        print("DEBUG PRINT:", "didTapoption4Button")
        
        selectedOption(uiButton: option4Button)
    }
    
    @objc private func didTapNextButton(){
        print("DEBUG PRINT:", "didTapNextButton")
        
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    private func selectedOption(uiButton: UIButton) {
        option1Button.backgroundColor = .tertiaryLabel
        option2Button.backgroundColor = .tertiaryLabel
        option3Button.backgroundColor = .tertiaryLabel
        option4Button.backgroundColor = .tertiaryLabel
  
        uiButton.backgroundColor = ColorGuide.primary
    }
    
}
