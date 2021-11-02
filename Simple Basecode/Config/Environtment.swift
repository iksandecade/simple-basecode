//
//  Environtment.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

// This is a configuration class for storing urls or global callable variables

import Foundation

let environment: Environment = .Development

enum Environment {
    case Production
    case Development
    
    var baseUrl: String {
        switch self {
        case .Production: return "https://example.co.id/"
        case .Development: return "https://example.co.id/"
        }
    }
}
