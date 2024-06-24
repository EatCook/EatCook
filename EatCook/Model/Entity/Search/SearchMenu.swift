//
//  SearchMenu.swift
//  EatCook
//
//  Created by 강신규 on 6/24/24.
//

import Foundation

struct SearchMenu: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: [SearchMenuData] // 데이터의 타입에 따라 적절히 수정 가능
}

struct SearchMenuData : Codable {
    let searchWord: String
    let searchCount: Int
}
