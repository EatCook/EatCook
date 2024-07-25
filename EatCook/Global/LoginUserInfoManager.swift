//
//  LoginUserInfoManager.swift
//  EatCook
//
//  Created by 이명진 on 7/23/24.
//

import Foundation

final class LoginUserInfoManager: ObservableObject {
    
    static let shared = LoginUserInfoManager()
    
    @Published var userInfo: UserInfo?
    
    private init() { }
    
}

struct UserInfo {
    var userId: Int
    var email: String
    var nickName: String
    var badge: String
    var followerCounts: Int
    var followingCounts: Int
    var providerType: String
    var profileImagePath: String?
}
