//
//  UserDetailGenderViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class UserDetailGenderViewController: UIViewController {
    
    //MARK: - UI Components
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let descriptionLabel = CustomLabel(labelType: .paragraph1,
                                               textColor: .secondaryLabel,
                                               textAlignment: .center)
    
    private let maleOptionButton = CustomButton(buttonType: .secondary,
                                                title: "👨🏻 Male",
                                                fontsize: .option)
    
    private let femaleOptionButton = CustomButton(buttonType: .secondary,
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
        
        maleOptionButton.addTarget(self, action: #selector(didTapMaleOptionButton), for: .touchUpInside)
        femaleOptionButton.addTarget(self, action: #selector(didTapFemaleOptionButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(maleOptionButton)
        view.addSubview(femaleOptionButton)
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
            
            maleOptionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 75),
            maleOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            maleOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            maleOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            femaleOptionButton.topAnchor.constraint(equalTo: maleOptionButton.bottomAnchor, constant: 10),
            femaleOptionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            femaleOptionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            femaleOptionButton.heightAnchor.constraint(equalToConstant: 65),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        headerLabel.text = "What's Your gender?"
        descriptionLabel.text = "Your coach will design your \nworkouts that best suit your \ngender"
    }
    
    // MARK: - Selectors
    @objc private func didTapMaleOptionButton(){
        //        print("DEBUG PRINT:", "didTapMaleOptionButton")
        
        selectedOption(uiButton: maleOptionButton)
        AuthManager.gender = "Male"
    }
    
    @objc private func didTapFemaleOptionButton(){
        //        print("DEBUG PRINT:", "didTapFemaleOptionButton")
        
        selectedOption(uiButton: femaleOptionButton)
        AuthManager.gender = "Female"
    }
    
    @objc private func didTapNextButton(){
        //        print("DEBUG PRINT:", "didTapNextButton")
        
        if !(AuthManager.gender == "") {
            let vc = UserDetailHeightViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            //        let vc = UserDetailHeightViewController()
            //        vc.modalPresentationStyle = .fullScreen
            //        self.present(vc, animated: false, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alert",
                                          message: "Please select a gender.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func selectedOption(uiButton: UIButton) {
        maleOptionButton.backgroundColor = .tertiaryLabel
        femaleOptionButton.backgroundColor = .tertiaryLabel
        
        uiButton.backgroundColor = ColorGuide.primary
    }
    
}
