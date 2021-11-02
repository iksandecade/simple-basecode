//
//  APIList.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

import Foundation

struct APIList {
    let baseURL = environment.baseUrl
    
    var sampleRequest: URL {
        return URL(string: baseURL + "sample")!
    }
}
