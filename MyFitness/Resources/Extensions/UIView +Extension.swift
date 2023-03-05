//
//  UIView +Extension.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit

extension UIView{
    
    //This function will add a layer on any `UIView` to make that `UIView` look darkened
    func addoverlay(color: UIColor = .black,alpha : CGFloat = 0.2) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
}
