//
//  MyPageProfileEditRequestResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/23/24.
//

import Foundation

/// 닉네임 업데이트

struct MyPageProfileEditRequestResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data: [MyPageProfileEditRequestResponseData] = []
}

struct MyPageProfileEditRequestResponseData: Codable {
    
}

/// 이미지 업데이트

struct MyPageProfileImageEditResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data = MyPageProfileImageEditResponseData()
}

struct MyPageProfileImageEditResponseData: Codable {
    var presignedUrl: String = ""
}
