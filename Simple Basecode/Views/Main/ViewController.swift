//
//  ViewController.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.responseDelegate = self //Always call responseDelegate if you want to get data from response api
    }
}

extension ViewController: ResponseForViewDelegate {
    func getResponse(response: Any?) {
        // This is success get data from api
        if let sampleList = response as? [SampleResponseModel] {
            print(sampleList)
        }
    }
    
    func getResponseError(response: Any?) {
        // This is error or failed get data from api
        if let errorResponse = response as? ServiceError {
            print(errorResponse)
        }
    }
}

