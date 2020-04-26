//
//  UITextField+Helper.swift
//  Supplement Superstores
//
//  Created by mac on 25/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

// 1
class MaxLengthTextField: UITextField, UITextFieldDelegate {
    
    // 2
    private var characterLimit: Int?
    
    // 3
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    // 4
    @IBInspectable var maxLength: Int {
        get {
            guard let length = characterLimit else {
                return Int.max
            }
            return length
        }
        set {
            characterLimit = newValue
        }
    }
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 2
        guard string.count > 0 else {
            return true
        }
        
        // 3
        let currentText = textField.text ?? ""
        // 4
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        // 5
        return prospectiveText.count <= maxLength
    }
}
