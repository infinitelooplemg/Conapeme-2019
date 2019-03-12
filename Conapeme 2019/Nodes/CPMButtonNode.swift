//
//  CPMButtonNode.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class CPMButtonNode:ASButtonNode {
    
    init(fontSize:Float,textColor:UIColor,with text:String) {
        super.init()
        setTitle(text, with: UIFont.boldSystemFont(ofSize: CGFloat(fontSize)), with: textColor, for: .normal)
        cornerRadius = 5
        backgroundColor = UIColor.CPMGreen
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
    }
}


class CPMWhiteButtonNode:ASButtonNode {
    
    init(fontSize:Float,with text:String) {
        super.init()
        setTitle(text, with: UIFont.boldSystemFont(ofSize: CGFloat(fontSize)), with: UIColor.CPMGreen, for: .normal)
        cornerRadius = 5
        borderColor = UIColor.CPMGreen.cgColor
        borderWidth = 0.2
        backgroundColor = .white
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
    }
}
