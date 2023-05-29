//
//  UserDetailCaptureViewController.swift
//  MyFitness
//
//  Created by Sachin on 5/20/23.
//

import UIKit

class UserDetailHeightViewController: UIViewController {
    
    //MARK: - Variables
    var HeightList = ["5.00", "5.01", "5.02", "5.03", "5.04", "5.05", "5.06", "5.07", "5.08", "5.09", "5.10", "5.11", "6.0", "6.01", "6.02", "6.03"]
    var defaultSelectedRow = 5
    
    //MARK: - UI Components
    private let headerLabel = CustomLabel(labelType: .header1,
                                          textColor: .label,
                                          textAlignment: .center)
    
    private let heightValueTypeLabel = CustomLabel(labelType: .card,
                                                   textColor: .label,
                                                   textAlignment: .center)
    
    private let heighValueLabel = CustomLabel(labelType: .header2,
                                                   textColor: .label,
                                                   textAlignment: .center)
    
    private let heightPickerView = UIPickerView()
    
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
        
        heightPickerView.selectRow(defaultSelectedRow, inComponent: 0, animated: false)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    //  MARK: - Add Subviews
    private func addSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(heightValueTypeLabel)
        view.addSubview(heighValueLabel)
        view.addSubview(heightPickerView)
        view.addSubview(nextButton)
        
        heightPickerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //  MARK: - UI Setup Constraints
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            heightValueTypeLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 35),
            heightValueTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightValueTypeLabel.widthAnchor.constraint(equalToConstant: 75),
            heightValueTypeLabel.heightAnchor.constraint(equalToConstant: 45),
            
            heighValueLabel.topAnchor.constraint(equalTo: heightValueTypeLabel.bottomAnchor, constant: 20),
            heighValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heighValueLabel.widthAnchor.constraint(equalToConstant: 100),
            
            heightPickerView.topAnchor.constraint(equalTo: heighValueLabel.bottomAnchor, constant: 1),
            heightPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightPickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            heightPickerView.heightAnchor.constraint(equalToConstant: 325),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
    }
    
    //  MARK: - SetUp Picker View
    private func setUpPickerView() {
        heightPickerView.delegate = self
        heightPickerView.dataSource = self
    }
    
    //  MARK: - Setup Values
    private func setUpValues() {
        headerLabel.text = "What's Your Current \nHeight?"
        heightValueTypeLabel.text = "Ft"
        AuthManager.height = Double(HeightList[defaultSelectedRow])!
        heighValueLabel.text = "\(HeightList[defaultSelectedRow]) Ft"
    }
    
    // MARK: - Selectors
    @objc private func didTapNextButton(){
        //        print("DEBUG PRINT:", "didTapNextButton")
        
        let vc = UserDetailWeightViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        //        let vc = UserDetailWeightViewController()
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: false, completion: nil)
    }
    
}

//MARK: - UI Picker View Section
extension UserDetailHeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HeightList.count
    }
      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = HeightList[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = HeightList[row]
        AuthManager.height = Double(selectedValue)!
        heighValueLabel.text = "\(selectedValue) Ft"
    }
    
}
