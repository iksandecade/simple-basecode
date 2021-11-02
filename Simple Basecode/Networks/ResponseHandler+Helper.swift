//
//  ResponseHandler+Helper.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

import Foundation

struct ServiceError : Error, Codable {
    let httpStatus : Int
    let message : String
}

extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonEncoder = JSONDecoder()
        do {
            if response.statusCode == 200 {
                let baseResponse = try! jsonEncoder.decode(BaseResponse<T>.self, from: data)
                
                if let response = baseResponse.results, baseResponse.success == true {
                    return response
                } else {
                    throw ServiceError(httpStatus: response.statusCode, message: baseResponse.message ?? "")
                }
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        }catch {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription.debugDescription + " " + error.localizedDescription)
        }
    }
}
