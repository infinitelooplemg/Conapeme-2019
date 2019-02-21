//
//  CPMTextField.swift
//  Conapeme
//
//  Created by FABY on 2/11/19.
//  Copyright © 2019 Grupo Lider. All rights reserved.
//

import Foundation
import UIKit
class CPMTextField: UITextField {
    
    let inset: CGFloat = 8
    
    
    init(placeholder:String,isSecure:Bool) {
        super.init(frame: .zero)
        isSecureTextEntry = isSecure
        autocorrectionType = .no
        translatesAutoresizingMaskIntoConstraints = false
        textColor = UIColor.lightGray
        backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        layer.cornerRadius = 5
        self.placeholder = placeholder
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
}

extension CPMTextField:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
