//
//  CustomImageView.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit

class CustomImageView: UIImageView {
    
    enum ImageType {
        case background
        case page
        case table
        case collection
    }
    
    enum ImageLayout {
        case light
        case dark
    }
    
    init(image: UIImage, imageType: ImageType, imageLayout: ImageLayout){
        super.init(frame: .zero)
        
        self.image = image
      
        switch imageType{
        case .background:
            self.contentMode = .scaleAspectFill
        case .page:
            self.contentMode = .scaleToFill
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .table:
            self.contentMode = .scaleToFill
            self.layer.borderWidth = 1.5
            self.layer.borderColor = ColorGuide.primary.cgColor
        case .collection:
            self.contentMode = .scaleToFill
            self.layer.borderWidth = 1.5
            self.layer.borderColor = ColorGuide.primary.cgColor
        }
        
        if (imageLayout == .dark){
            self.addoverlay()
        }
        
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
