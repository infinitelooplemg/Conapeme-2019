//
//  WorkshopCellNode.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class WorkshopCellNode:ASCellNode {
    var workshop:Workshop?
    
    var topicTextNode:CPMTextNode!
    var descriptionTextnode:CPMTextNode!
    var dayTextNode:CPMTextNode!
    var scheduleTextNode:CPMTextNode!
    
    var setWorkshopButton:CPMButtonNode!
    var showAsistanteList:CPMWhiteButtonNode!
    
    weak var delegate:WorkshopCellNodeDelegate!
    
    init(workshop:Workshop,delegate:WorkshopCellNodeDelegate) {
        super.init()
        self.delegate = delegate
        self.workshop = workshop
        automaticallyManagesSubnodes = true
        initializeSubnodes()
        selectionStyle = .none
    }
    
    func initializeSubnodes()  {
        topicTextNode = CPMTextNode(boldFontSize: 22, color: UIColor.black, with: workshop!.topic)
        descriptionTextnode = CPMTextNode(fontSize: 15, color: UIColor.lightGray, with: workshop!.description)
        formatDateForTextNodes()
        
        setWorkshopButton = CPMButtonNode(fontSize: 13, textColor: .white, with: "Tomar Asistencia")
        setWorkshopButton.addTarget(self, action: #selector(takeAssistance), forControlEvents: .touchUpInside)
        showAsistanteList = CPMWhiteButtonNode(fontSize: 13, with: "Lista de Asistencia")
        showAsistanteList.addTarget(self, action: #selector(showAssistanceList), forControlEvents: .touchUpInside)
    }
    
    @objc func takeAssistance(){
        delegate.takeAssitanceFor(workshopId: (workshop?.id)!)
    }
    
    @objc func showAssistanceList(){
        delegate.showAssitanceListFor(workshopId: (workshop?.id)!)
    }
    
    func formatDateForTextNodes(){
        guard let startDate = workshop?.start_date , let endDate = workshop?.end_date else {
            return
        }
        
        let localizedStartDate = getDateFromString(date: startDate)
        let localizedEndDate = getDateFromString(date: endDate)
        
        let dateComponents = getDayMonthYearComponentFrom(date: localizedStartDate)
        let startTimeComponents = getHourMinutesFrom(date: localizedStartDate)
        let endTimeComponents = getHourMinutesFrom(date: localizedEndDate)
        
        dayTextNode = CPMTextNode(boldFontSize: 22, color: .black, with: dateComponents)
        scheduleTextNode = CPMTextNode(fontSize: 15, color: UIColor.lightGray, with:"\(startTimeComponents) - \(endTimeComponents)")
    }
    
    
    func getDayMonthYearComponentFrom(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    func getHourMinutesFrom(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
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
        contentStack.children = [topicTextNode,descriptionTextnode,dayTextNode,scheduleTextNode,setWorkshopButton,showAsistanteList]
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
