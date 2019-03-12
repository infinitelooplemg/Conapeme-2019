//
//  WorkshopAssistantCellNode.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class WorkshopAssistantCellNode:ASCellNode {
    var assistant:WorkshopAssistant?
    
    var nameTextNode:CPMTextNode!
    var timestampTextNode:CPMTextNode!
    var logisticUser:CPMTextNode!
    
    init(assistant:WorkshopAssistant) {
        super.init()
        self.assistant = assistant
        automaticallyManagesSubnodes = true
        initializeSubnodes()
        selectionStyle = .none
    }
    
    func initializeSubnodes()  {
        nameTextNode = CPMTextNode(boldFontSize: 18, color: UIColor.black, with: (assistant?.assistant_name)!)
        logisticUser = CPMTextNode(boldFontSize: 13, color: UIColor.CPMGreen, with: (assistant?.logistics_user)!)
        logisticUser.style.alignSelf = .end
      
        formatDateForTextNodes()
        
     
    }
    
    
    func formatDateForTextNodes(){
        guard let registrationTime = assistant?.registration_time else {
            return
        }
        
        let localizedRegistrationDate = getDateFromString(date: registrationTime)
        let localizedRegistrationDateString = toLocal(date: localizedRegistrationDate)
     
        
        timestampTextNode = CPMTextNode(fontSize: 13, color: .lightGray, with: localizedRegistrationDateString)
    }
    
    
    func toLocal(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: date)
    }
   
    func getDateFromString(date:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//this your string date format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.date(from: date)!
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [nameTextNode,timestampTextNode,logisticUser]
        contentStack.spacing = 8
        
        let backgroundNode = ASDisplayNode()
        backgroundNode.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        backgroundNode.cornerRadius = 5
        
        let internalInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let internalInsetSpecs = ASInsetLayoutSpec(insets: internalInsets, child: contentStack)
        
        let back = ASBackgroundLayoutSpec(child: internalInsetSpecs, background: backgroundNode)
        
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: back)
        
        return insetSpecs
    }
}
