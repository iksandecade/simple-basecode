//
//  SampleService.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

// This is a service class, used to call api and pass parameters. the rule is that one service can only call 1 request
import Foundation

struct SampleService: APIHandler {
    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let url =  APIList().sampleRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        return urlRequest
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> [SampleResponseModel] {
        return try defaultParseResponse(data: data,response: response)
    }
}
