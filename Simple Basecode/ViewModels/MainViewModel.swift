//
//  MainViewModel.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

// this is viewmodel class, used to call the service and process the api response data. the rules in the datasource must be stored in viewmodel, not to be stored in view

import Foundation

final class MainViewModel {
    
    var sampleList = [SampleResponseModel]()
    
    weak var responseDelegate: ResponseForViewDelegate?
    
    func getData() {
        let request = SampleService()
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: [String:Any]()) { [weak self] models, error in
            if let _ = error {
                self?.responseDelegate?.getResponse(response: models)
            } else {
                if let models = models{
                    self?.sampleList = models
                    self?.responseDelegate?.getResponse(response: models)
                }
            }
        }
    }
}
