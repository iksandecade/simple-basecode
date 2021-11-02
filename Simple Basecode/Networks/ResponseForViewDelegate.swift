//
//  ResponseForViewDelegate.swift
//  Simple Basecode
//
//  Created by MCOMM00008 on 02/11/21.
//

import Foundation

@objc protocol ResponseForViewDelegate {
    func getResponse(response: Any?)
    @objc optional func getResponseError(response: Any?)
}
