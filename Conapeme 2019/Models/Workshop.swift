//
//  Workshop.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/11/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct Workshop:Decodable {
    var description:String
    var end_date:String
    var id:Int
    var room_id:Int
    var room_name:String
    var start_date:String
    var topic:String
}


