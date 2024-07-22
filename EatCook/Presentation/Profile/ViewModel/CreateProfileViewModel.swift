//
//  CreateProfileViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/22/24.
//

import Foundation
import SwiftUI

class CreateProfileViewModel : ObservableObject {
    @Published var nickname: String = "" {
        didSet {
            validate()
        }
    }
    @Published var isNickNameImageValid: Bool = false
    
    @Published var userImage: UIImage? = nil {
        didSet {
            validate()
        }
    }

    private func validate() {
        let isValidNickname = isValidKoreanNickname(nickname)
        let hasImage = userImage != nil
        isNickNameImageValid = isValidNickname && hasImage
    }
    
    private func isValidKoreanNickname(_ nickname: String) -> Bool {
        let pattern = "^[가-힣]{2,6}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: nickname.utf16.count)
        return regex?.firstMatch(in: nickname, options: [], range: range) != nil
    }
    
    
    
    
    
}
