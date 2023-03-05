//
//  CustomButton.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit

class CustomButton: UIButton {
    
    enum ButtonType {
        case primary
        case secondary
        case label
    }

    enum FontSize {
        case big
        case med
        case small
    }

    init(buttonType: ButtonType, title: String, fontsize: FontSize){
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch buttonType{
        case .primary:
            self.backgroundColor = ColorGuide.primaryColor
            self.setTitleColor(.label, for: .normal)
        case .secondary:
            self.backgroundColor = .systemBlue
            self.setTitleColor(.white, for: .normal)
        case .label:
            self.layer.borderColor = UIColor.systemBlue.cgColor
            self.layer.borderWidth = 2
            self.backgroundColor = .white
            self.setTitleColor(.systemBlue, for: .normal)
        }
        
        switch fontsize{
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
