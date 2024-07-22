//
//  HouseholdCompositionViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/22/24.
//

import Foundation
import SwiftUI

class HouseholdCompositionViewModel : ObservableObject {
    
    
    @Published private var lifeType : String? = nil
    
    @Published var email: String = ""
    @Published var cookingType:  [String] = []
    @Published var userImage: UIImage? = nil
    

    
}
