//
//  OtherUserInfoResponse.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation

struct OtherUserInfoResponse: Codable {
    var success: Bool = false
    var code: String = ""
    var message: String = ""
    var data = OtherUserInfoResponseData()
}

struct OtherUserInfoResponseData: Codable {
    var userId: Int = 0
    var email: String = ""
    var userImagePath: String = ""
    var nickName: String = ""
    var badge: String = ""
    var followerCounts: Int = 0
    var followCheck: Bool = false
    var postCounts: Int = 0
}
