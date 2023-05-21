//
//  UserDetailWeightViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class UserDetailWeightViewController: UIViewController {
    
    //MARK: - Variables
    var WeightList = ["77", "78", "79", "80", "81", "82", "83", "84", "85"]
    
    //MARK: - UI Components
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let weightValueTypeLabel = CustomLabel(labelType: .card,
                                                   textColor: .label,
                                                   textAlignment: .center)
    
    private let weightPickerView = UIPickerView()
    
    private let nextButton = CustomButton(buttonType: .primary,
                                          title: "Next",
                                          fontsize: .big)

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubviews()
        setUpConstraints()
        setUpPickerView()
        setUpValues()
        
        weightPickerView.selectRow(4, inComponent: 0, animated: false)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(weightValueTypeLabel)
        view.addSubview(weightPickerView)
        view.addSubview(nextButton)
        
        weightPickerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            weightValueTypeLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 45),
            weightValueTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightValueTypeLabel.widthAnchor.constraint(equalToConstant: 75),
            weightValueTypeLabel.heightAnchor.constraint(equalToConstant: 45),
            
            weightPickerView.topAnchor.constraint(equalTo: weightValueTypeLabel.bottomAnchor, constant: 20),
            weightPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightPickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            weightPickerView.heightAnchor.constraint(equalToConstant: 300),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
            
        ])
        
    }
    
    //  MARK: - SetUp Picker View
    private func setUpPickerView() {
        weightPickerView.delegate = self
        weightPickerView.dataSource = self
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        headerLabel.text = "What's Your Current \nWeight?"
        weightValueTypeLabel.text = "Kg"
    }
    
    // MARK: - Selectors
    @objc private func didTapNextButton(){
        //        print("DEBUG PRINT:", "didTapNextButton")
        
        let vc = UserDetailFitnessGoalViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
}

//MARK: - UI Picker View Section
extension UserDetailWeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return WeightList.count
    }
      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = WeightList[row]
        return row
    }
    
}
