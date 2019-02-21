//
//  Hotel.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct HotelsResponse:Decodable {
    var hotels:[Hotel]
}


struct Hotel:Decodable {
    var name:String
    var available:Bool
    var description:String
    var price:Double
    var img_uri:String
}
