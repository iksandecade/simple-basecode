//
//  BaseModels.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

// this is the basemodel class to store the response base mapping
import Foundation

struct BaseResponse<T: Codable>: Codable {
    var success: Bool?
    var message: String?
    var results: T?
}
