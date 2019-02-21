//
//  HomeNode.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import SafariServices

class HomeNode:ASScrollNode{
    
    var  ladyImage:ASImageNode = {
        let img = ASImageNode()
        img.style.preferredSize = CGSize(width: 300, height: 300)
        img.cornerRadius = 150
        img.image = UIImage(named: "senora")
        return img
    }()
    
    var teamButon:ASButtonNode = {
        let b = ASButtonNode()
        b.style.preferredSize.height = 44
        b.cornerRadius = 5
        b.setTitle("Ver Comité Organizador", with: UIFont.boldSystemFont(ofSize: 15), with: .white, for: .normal)
        b.backgroundColor = UIColor.CPMGreen
        return b
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        teamButon.addTarget(self, action: #selector(openLink), forControlEvents: .touchUpInside)
    }
    
    
    @objc func openLink(){
        let url = URL(string: "https://site.conapemecongresos.org/comit%C3%A9-organizador#69e1b976-6aa3-4b87-a8fe-268d55477ab6")
        let vc = SFSafariViewController(url: url!)
        closestViewController!.present(vc, animated: true, completion: nil)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec.vertical()
        stack.alignItems = .center
        stack.spacing = 16
        
        let welcomeText = CPMTextNode(boldFontSize: 30, color: UIColor.CPMGreen, with: "Mensaje de Bienvenida")
        
        let textStack = ASStackLayoutSpec.vertical()
        textStack.spacing = 8
        textStack.children = [CPMTextNode(boldFontSize: 20, color: .black, with: "Estimados Amigos y Amigas"),CPMTextNode(fontSize: 16, color: .black, with: String.cpmMessage1),CPMTextNode(boldFontSize: 16, color: .black, with: String.cpmMessage2),CPMTextNode(fontSize: 16, color: .black, with: String.cpmMessage3),CPMTextNode(fontSize: 16, color: .black, with: String.cpmMessage4),CPMTextNode(fontSize: 16, color: .black, with: String.cpmMessage5),CPMTextNode(boldFontSize: 16, color: .black, with: String.cpmMessage6),CPMTextNode(boldFontSize: 16, color: .black, with: "Atentamente \nDra. Maria Soledad Millán Lizarraga \nPresidente"),teamButon]
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetLayoutSpec = ASInsetLayoutSpec(insets: insets, child: textStack)
        
        stack.children = [welcomeText,ladyImage,insetLayoutSpec]
        return stack
    }
}
