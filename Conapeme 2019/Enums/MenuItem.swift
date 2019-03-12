//
//  MenuItem.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//


import Foundation
import UIKit

enum MenuItem:Int  {
    case fechaEvento = 1
    case sede = 2
    case planoCongreso = 3
    case manualExpositor = 4
    case programaGeneral = 5
    case montaje = 6
    case stands = 7
    case encuestaProveedores = 8
    case hoteles = 9
    case servicios  = 10
    case live = 11
    case registration = 12
    
    
    var description: (String) {
        switch self {
        case .fechaEvento:
            return "Fecha del Evento"
        case .sede :
            return "Sede"
        case .planoCongreso :
            return "Plano del Congreso"
        case .manualExpositor :
            return "Manual del Expositor"
        case .programaGeneral:
            return "Programa General"
        case .montaje:
            return "Montaje y Desmontaje"
        case .stands:
            return "Stands"
        case .encuestaProveedores:
            return "Encuestas para Proveedores"
        case .hoteles :
            return "Hoteles"
        case .live:
            return "En vivo"
        case .servicios:
            return "Servicios Adicionales"
        case .registration:
            return "Registro de Asistencia"
        }
        
    }
    
    var icon:(UIImage?) {
        switch self {
        case .fechaEvento:
            return UIImage(named: "calendar")
        case .sede :
            return UIImage(named: "sede")
        case .planoCongreso :
            return UIImage(named: "plano")
        case .manualExpositor :
            return UIImage(named: "manual")
        case .programaGeneral:
            return UIImage(named: "programa")
        case .montaje:
            return UIImage(named: "montaje")
        case .stands:
            return UIImage(named:   "stands")
        case .encuestaProveedores:
            return UIImage(named:   "encuesta")
        case .hoteles :
            return UIImage(named: "hoteles")
        case .servicios:
            return UIImage(named: "servicios")
        case .live:
            return UIImage(named: "live")
        case .registration:
            return UIImage(named: "calendar")
        }
        
    }
}
