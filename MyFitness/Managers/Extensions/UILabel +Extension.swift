//
//  File.swift
//  MyFitness
//
//  Created by Sachin on 3/7/23.
//

import UIKit

extension UILabel {
    
    func addTrailing(image: UIImage, text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: text, attributes: [:])
        
        string.append(attachmentString)
        self.attributedText = string
    }
    
    func addLeading(image: UIImage, text: String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let string = NSMutableAttributedString(string: text, attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
    
    func addLeadingWithPrefix(prefix: String, image: UIImage, text: String) {
        let mutableAttributedString = NSMutableAttributedString()
        
        let stringPrefix = NSMutableAttributedString(string: prefix, attributes: [:])
        mutableAttributedString.append(stringPrefix)
        
        let attachment = NSTextAttachment()
        attachment.image = image
        let attachmentString = NSAttributedString(attachment: attachment)
        mutableAttributedString.append(attachmentString)
        
        let string = NSMutableAttributedString(string: text, attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
    
}
