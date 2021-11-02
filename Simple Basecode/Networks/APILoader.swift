//
//  APILoader.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

import Foundation

class APILoader<T: APIHandler> {
    let apiHandler: T
    let urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType,
                        completionHandler: @escaping (T.ResponseDataType?, ServiceError?) -> ()){
        if let urlRequest = apiHandler.makeRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) {(data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    do {
                        if httpResponse.statusCode == 200 {
                            let response = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)
                            
                            completionHandler(response, nil)
                        } else {
                            completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: httpResponse.description))
                        }
                    } catch {
                        completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "ServiceError : \(error.localizedDescription)"))
                    }
                    
                }
            }.resume()
        }
    }
}
