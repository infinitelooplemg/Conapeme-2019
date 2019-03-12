//
//  AddAssitanceToWorkshopRequestParameters.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct AddAssitanceToWorkshopRequestParameters:Codable {
    var assistantId:Int
    var workshopId:Int
    var logisticsId:String
}
