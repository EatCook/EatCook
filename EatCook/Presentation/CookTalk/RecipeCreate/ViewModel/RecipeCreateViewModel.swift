//
//  RecipeCreateViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import SwiftUI

final class RecipeCreateViewModel: ObservableObject {
    @Published var recipeStepData: [RecipeStep] = []
    
    func addStep(_ data: RecipeStep) {
        recipeStepData.append(data)
    }
    
    func editStep(_ data: RecipeStep, _ index: Int) {
        recipeStepData[index] = data
    }
    
    func deleteStep() {
        
    }
}
