//
//  CustomHorizontalBar.swift
//  MyFitness
//
//  Created by Sachin on 3/7/23.
//

import UIKit

class CustomHorizontalBar: UIView {
    
    init(backgroundColor: UIColor){
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
