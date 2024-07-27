//
//  MyPageArchiveResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/22/24.
//

import Foundation

struct MyPageArchiveResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data: [MyPageArchiveData] = []
}

struct MyPageArchiveData: Codable, Identifiable {
    var postId: Int = 0
    var postImagePath: String = ""
    
    var id: String = UUID().uuidString
}
