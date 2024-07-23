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
    var email: String
    var nickName: String
    var profileImagePath: String?
}
