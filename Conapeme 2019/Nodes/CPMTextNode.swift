import Foundation
import AsyncDisplayKit

class CPMTextNode:ASTextNode {
    
    fileprivate var _fontSize:Float!
    fileprivate var _color:UIColor!
    fileprivate var _text:String!
    
    init(fontSize:Float,color:UIColor,with text:String) {
        super.init()
        isLayerBacked = true
        _fontSize = fontSize
        _color = color
        _text = text
        attributedText = NSAttributedString(string: _text, attributes: [NSAttributedString.Key.foregroundColor:_color,NSAttributedString.Key.font:UIFont.systemFont(ofSize: CGFloat(_fontSize!))])
    }
    
    
    init(boldFontSize:Float,color:UIColor,with text:String) {
        super.init()
        isLayerBacked = true
        _fontSize = boldFontSize
        _color = color
        _text = text
        attributedText = NSAttributedString(string: _text, attributes: [NSAttributedString.Key.foregroundColor:_color,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: CGFloat(_fontSize!))])
    }
    
}
//
//  CPMTextNode.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//


