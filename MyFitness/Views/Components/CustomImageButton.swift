//
//  CustomImageButton.swift
//  MyFitness
//
//  Created by Sachin on 5/13/23.
//

import UIKit

class CustomImageButton: UIButton {
    
    init(image: UIImage, pointSize: CGFloat, cornerRadius: CGFloat, tintColor: UIColor, backgroundColor: UIColor){
        super.init(frame: .zero)
        
        self.setImage(image, for: .normal)
        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: pointSize), forImageIn: .normal)
        self.layer.cornerRadius = cornerRadius
        self.imageView?.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
