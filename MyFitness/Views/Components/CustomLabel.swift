//
//  CustomLabel.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit

class CustomLabel: UILabel {
    
    enum LabelType {
        case header1
        case header2
        case header3
        case header4
        case header5
        case text1
        case text2
        case text3
        case text4
        case paragraph1
        case paragraph2
        case card
        case key
        case value
    }

    init(labelType: LabelType, textColor: UIColor, textAlignment: NSTextAlignment){
        super.init(frame: .zero)
        
        self.text = "Error"
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch labelType{
        case .header1:
            self.font = .systemFont(ofSize: 30, weight: .bold)
        case .header2:
            self.font = .systemFont(ofSize: 25, weight: .bold)
        case .header3:
            self.font = .systemFont(ofSize: 21, weight: .semibold)
        case .header4:
            self.font = .systemFont(ofSize: 20, weight: .semibold)
        case .header5:
            self.font = .systemFont(ofSize: 18, weight: .semibold)
        case .text1:
            self.font = .systemFont(ofSize: 18, weight: .medium)
        case .text2:
            self.font = .systemFont(ofSize: 18, weight: .light)
        case .text3:
            self.font = .systemFont(ofSize: 16, weight: .semibold)
        case .text4:
            self.font = .systemFont(ofSize: 15, weight: .medium)
        case .paragraph1:
            self.font = .systemFont(ofSize: 18, weight: .medium)
        case .paragraph2:
            self.font = .systemFont(ofSize: 17, weight: .medium)
        case .card:
            self.font = .systemFont(ofSize: 20, weight: .bold)
            self.layer.cornerRadius = 10
            self.layer.masksToBounds = true
            self.backgroundColor = .tertiaryLabel
        case .key:
            self.font = .systemFont(ofSize: 16, weight: .regular)
        case .value:
            self.font = .systemFont(ofSize: 20, weight: .bold)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
