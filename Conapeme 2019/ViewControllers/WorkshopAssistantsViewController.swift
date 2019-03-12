//
//  WorkshopAssistantsViewController.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class WorkshopAssistantsViewController:ASViewController<ASTableNode> {
    var tableNode:ASTableNode
    var nl = CPMNetworkLayer()
    var workshopId:Int?
    var assistants:[WorkshopAssistant] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    
    init() {
        tableNode = ASTableNode()
        
        super.init(node: tableNode)
        tableNode.dataSource = self
        node.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.view.separatorStyle = .none
        setupNavigationButtons()
        navigationItem.title = "Lista de Asistencia"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        loadAssistants()
     
    }
    
    func loadAssistants(){
        nl.fetchAssistantsFor(workshopId: workshopId!) { (result, error) in
            if (error != nil) {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.assistants = (result?.result)!
                self.tableNode.reloadData()
            }
        }
    }
    
    func setupNavigationButtons(){
        let cancelButton = UIBarButtonItem(title: "Regresar", style: UIBarButtonItem.Style.plain, target: self , action: #selector(dismisViewController))
        navigationItem.setLeftBarButton(cancelButton, animated: true)
        
        navigationController?.navigationBar.barTintColor = UIColor.CPMGreen
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func dismisViewController(){
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WorkshopAssistantsViewController:ASTableDataSource{
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return assistants.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let assistant = assistants[indexPath.row]
        
        let cellNodeBlock = { [weak self]() -> ASCellNode in
            let cellNode = WorkshopAssistantCellNode(assistant: assistant)
            return cellNode
        }
        return cellNodeBlock
    }
}

