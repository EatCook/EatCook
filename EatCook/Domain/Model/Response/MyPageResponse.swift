//
//  MyPageResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import Foundation

struct MyPageResponse: Codable {
    let success: Bool
    let code, message: String
    let data: MyPageDataResponse
}

struct MyPageDataResponse: Codable {
    var userId: Int = 0
    var email: String = ""
    var nickName: String = ""
    var badge: String = ""
    var followerCounts: Int = 0
    var followingCounts: Int = 0
    var providerType: String = ""
}
