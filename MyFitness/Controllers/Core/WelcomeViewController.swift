//
//  WelcomeViewController.swift
//  MyFitness
//
//  Created by Sachin on 3/4/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //  MARK: - UI Components
    private let backgroundImageView = CustomImageView(image: UIImage(systemName: "questionmark")!,
                                                      imageType: .background,
                                                      imageLayout: .light)
    
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: ColorGuide.primary,
                                          textAlignment: .left)
    
    private let infoLabel = CustomLabel(labelType: .paragraph2,
                                          textColor: ColorGuide.secondary,
                                          textAlignment: .left)
    
    private let getStartedButton = CustomButton(buttonType: .primary,
                                                title: "Get Started",
                                                fontsize: .big)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        view.backgroundColor = .systemBackground
        
        view.addSubview(backgroundImageView)
        view.addSubview(headerLabel)
        view.addSubview(infoLabel)
        view.addSubview(getStartedButton)
        
        setUpValues()
        setUpConstraints()
        
        getStartedButton.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        backgroundImageView.image = UIImage(named: "background_welcome")
        let headerText = NSMutableAttributedString()
        headerText.append(NSAttributedString(string: "START ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]));
        headerText.append(NSAttributedString(string: "YOUR EXCERCISE ", attributes: [NSAttributedString.Key.foregroundColor: ColorGuide.primary]))
        headerText.append(NSAttributedString(string: "RIGHT NOW", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]))
        headerLabel.attributedText = headerText
        infoLabel.text = "Start your traning today before you before you regret your decision for your body."
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -10),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            infoLabel.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -30),
            infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            getStartedButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            getStartedButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            getStartedButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
    }
    
    // MARK: - Selectors
    @objc private func didTapGetStarted(){
        //        print("DEBUG PRINT:", "didTapGetStarted")
        
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
}
