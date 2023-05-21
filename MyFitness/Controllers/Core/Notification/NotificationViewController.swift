//
//  NotificationViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    //MARK: - UI Components
    private let spinner = CustomSpinner(size: .med,
                                        tintColor: ColorGuide.primary)
    
    private let notificationLabel1 = CustomLabel(labelType: .card,
                                                 textColor: .label,
                                                 textAlignment: .left)
    
    private let notificationLabel2 = CustomLabel(labelType: .card,
                                                 textColor: .label,
                                                 textAlignment: .left)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Notification"
        
        addSubviews()
        setUpConstraints()
        setUpValues()
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(spinner)
        view.addSubview(notificationLabel1)
        view.addSubview(notificationLabel2)
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            notificationLabel1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            notificationLabel1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            notificationLabel1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            notificationLabel1.heightAnchor.constraint(equalToConstant: 70),
            
            notificationLabel2.topAnchor.constraint(equalTo: notificationLabel1.bottomAnchor, constant: 10),
            notificationLabel2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            notificationLabel2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            notificationLabel2.heightAnchor.constraint(equalToConstant: 80),
        ])
        
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        visibleComponents(isVisible: false)
        
        let keyAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 19, weight: .semibold),
            .foregroundColor: UIColor.systemOrange
        ]
        let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        
        let attributedNotification1Text = NSMutableAttributedString()
        attributedNotification1Text.append(NSAttributedString(string: "  Upper Body Workout Reminder!", attributes: keyAttributes))
        attributedNotification1Text.append(NSAttributedString(string: "\n"))
        attributedNotification1Text.append(NSAttributedString(string: "\tYou have to start your workout within 20 mins.", attributes: valueAttributes))
        notificationLabel1.attributedText = attributedNotification1Text
        
        let attributedNotification2Text = NSMutableAttributedString()
        attributedNotification2Text.append(NSAttributedString(string: "  Lower Body Workout Reminder!", attributes: keyAttributes))
        attributedNotification2Text.append(NSAttributedString(string: "\n"))
        attributedNotification2Text.append(NSAttributedString(string: "\tStrengthen glutes: squats, deadlifts, calf raises. \tFocus on increase weights, stay consistent.", attributes: valueAttributes))
        notificationLabel2.attributedText = attributedNotification2Text
        
        visibleComponents(isVisible: true)
    }
    
    private func visibleComponents(isVisible: Bool) {
        if isVisible {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.spinner.stopAnimating()
                
                self.notificationLabel1.isHidden = false
                self.notificationLabel2.isHidden = false
                UIView.animate(withDuration: 0.4){
                    self.notificationLabel1.alpha = 1
                    self.notificationLabel2.alpha = 1
                }
            })
        }
        else {
            spinner.startAnimating()
            
            self.notificationLabel1.isHidden = true
            self.notificationLabel1.alpha = 0
            self.notificationLabel2.isHidden = true
            self.notificationLabel2.alpha = 0
        }
    }
    
}
