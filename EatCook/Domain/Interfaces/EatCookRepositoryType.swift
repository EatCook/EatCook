//
//  EatCookRepositoryType.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation

protocol EatCookRepositoryType: AnyObject {
    /// API별로 생성해서 사용.
    func fetchLoginInfo(of endpoint: EndPoint) async throws -> Result<LoginResponse, NetworkError>
}
