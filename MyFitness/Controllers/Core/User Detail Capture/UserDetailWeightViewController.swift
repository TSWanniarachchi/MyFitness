//
//  UserDetailWeightViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class UserDetailWeightViewController: UIViewController {
    
    //MARK: - Variables
    var wholeWeightList = ["72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86"]
    var fractionalWeightList = [".0", ".1", ".2", ".3", ".4", ".5", ".6", ".7", ".8", ".9"]
    var defaultSelectedRow = 4
    var wholeWeightSelectedOption = "0"
    var fractionalWeightSelectedOption = "0"
    
    //MARK: - UI Components
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let weightValueTypeLabel = CustomLabel(labelType: .card,
                                                   textColor: .label,
                                                   textAlignment: .center)
    
    private let weightValueLabel = CustomLabel(labelType: .header2,
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
        
        weightPickerView.selectRow(defaultSelectedRow, inComponent: 0, animated: false)
        weightPickerView.selectRow(defaultSelectedRow, inComponent: 1, animated: false)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(weightValueTypeLabel)
        view.addSubview(weightValueLabel)
        view.addSubview(weightPickerView)
        view.addSubview(nextButton)
        
        weightPickerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            weightValueTypeLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 35),
            weightValueTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightValueTypeLabel.widthAnchor.constraint(equalToConstant: 75),
            weightValueTypeLabel.heightAnchor.constraint(equalToConstant: 45),
            
            weightValueLabel.topAnchor.constraint(equalTo: weightValueTypeLabel.bottomAnchor, constant: 20),
            weightValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightValueLabel.widthAnchor.constraint(equalToConstant: 100),
            
            weightPickerView.topAnchor.constraint(equalTo: weightValueLabel.bottomAnchor, constant: 1),
            weightPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightPickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            weightPickerView.heightAnchor.constraint(equalToConstant: 325),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
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
        wholeWeightSelectedOption = wholeWeightList[defaultSelectedRow]
        fractionalWeightSelectedOption = fractionalWeightList[defaultSelectedRow]
        AuthManager.weight = Double("\(wholeWeightSelectedOption)\(fractionalWeightSelectedOption)")!
        weightValueLabel.text = "\(wholeWeightSelectedOption)\(fractionalWeightSelectedOption) Kg"
    }
    
    // MARK: - Selectors
    @objc private func didTapNextButton(){
        //        print("DEBUG PRINT:", "didTapNextButton")
        
        let vc = UserDetailFitnessGoalViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        //        let vc = UserDetailFitnessGoalViewController()
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: false, completion: nil)
    }
    
}

//MARK: - UI Picker View Section
extension UserDetailWeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return wholeWeightList.count
        }
        else {
            return fractionalWeightList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return wholeWeightList[row]
        }
        else {
            return fractionalWeightList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            wholeWeightSelectedOption = wholeWeightList[row]
        }else {
            fractionalWeightSelectedOption = fractionalWeightList[row]
        }
        let selectedValue = "\(wholeWeightSelectedOption)\(fractionalWeightSelectedOption)"
        AuthManager.weight = Double(selectedValue)!
        weightValueLabel.text = "\(selectedValue) Kg"
    }
    
}
