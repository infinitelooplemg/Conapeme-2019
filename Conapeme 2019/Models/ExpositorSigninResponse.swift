//
//  ExpositorSigninResponse.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
class ExpositorSigninResponse:Codable {
    var code:Int
    var result:Expositor?
    var errorMessage:String?
}

class Expositor:Codable{
    var id_expositor:Int?
    var company:String?
    var email:String?
}




struct ExpositorSigninRequestParameters:Codable {
    var expositorId:String
}
