//
//  ArchiveAddRequestResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/22/24.
//

import Foundation

struct ArchiveAddRequestResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data: [ArchiveAddRequestResponseData] = []
}

struct ArchiveAddRequestResponseData: Codable {
    
}
