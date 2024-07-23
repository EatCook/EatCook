//
//  MyPageProfileEditRequestResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/23/24.
//

import Foundation

struct MyPageProfileEditRequestResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data: [MyPageProfileEditRequestResponseData] = []
}

struct MyPageProfileEditRequestResponseData: Codable {
    
}
