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
    
    func updateStep(_ index: Int, _ selectedImage: UIImage?) {
        if let image = selectedImage {
            recipeStepData[index].image = image
            recipeStepData[index].isEditing.toggle()
        } else {
            recipeStepData[index].isEditing.toggle()
        }
    }
    
    func deleteStep() {
        
    }
}
