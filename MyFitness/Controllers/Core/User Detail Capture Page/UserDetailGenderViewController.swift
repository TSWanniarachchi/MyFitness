//
//  UserDetailGenderViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class UserDetailGenderViewController: UIViewController {
    
    //MARK: - Variables
    var genderlList = ["Male", "Female"]

    //MARK: - UI Components
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let descriptionLabel = CustomLabel(labelType: .paragraph1,
                                                   textColor: .label,
                                                   textAlignment: .center)
    
    private let option1Button = CustomButton(buttonType: .secondary,
                                          title: "👨🏻 Male",
                                          fontsize: .option)
    
    private let option2Button = CustomButton(buttonType: .secondary,
                                          title: "👩🏻 Female",
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
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(option1Button)
        view.addSubview(option2Button)
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
            
            option1Button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 75),
            option1Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            option1Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            option1Button.heightAnchor.constraint(equalToConstant: 65),
            
            option2Button.topAnchor.constraint(equalTo: option1Button.bottomAnchor, constant: 10),
            option2Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            option2Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            option2Button.heightAnchor.constraint(equalToConstant: 65),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        headerLabel.text = "What's Your gender?"
        descriptionLabel.text = "Your coach will design your \nworkouts that best suit your \ngender"
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
    
    @objc private func didTapNextButton(){
        print("DEBUG PRINT:", "didTapNextButton")
        
        let vc = UserDetailHeightViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    private func selectedOption(uiButton: UIButton) {
        option1Button.backgroundColor = .tertiaryLabel
        option2Button.backgroundColor = .tertiaryLabel
  
        uiButton.backgroundColor = ColorGuide.primary
    }
    
}
