//
//  HouseholdCompositionViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/22/24.
//

import Foundation
import SwiftUI

class HouseholdCompositionViewModel : ObservableObject {
    
    
   
    @Published var email: String = ""
    @Published var nickName: String = ""
    @Published var cookingType: [String] = []
    @Published var userImage: UIImage? = nil
    @Published var lifeType : String = ""
    
    init(email: String = "", nickName : String = "" ,cookingType: [String] = [], userImage: UIImage? = nil) {
        self.email = email
        self.nickName = nickName
        self.cookingType = cookingType
        self.userImage = userImage
        
    }
    
    
    
    // Modify the function to accept a completion handler
    func addSignUp(completion: @escaping (AddSignUpResponse) -> Void) {
        UserService.shared.addSignUp(parameters: [
            "email" : email,
            "fileExtension" : "jpg",
            "nickName" : nickName,
            "cookingType" : cookingType,
            "lifeType" : lifeType
        ]) { result in
            print("check result ::", result)
            completion(result)
        } failure: { error in
            print(error)
            completion(error)
        }
    }
    
    

}

enum AddSignUpResult {
    case success(AddSignUpResponse)
    case failure(Error)
}

