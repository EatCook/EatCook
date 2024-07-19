//
//  SearchViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import Foundation
import SwiftUI


class SearchViewModel : ObservableObject {
    
    
    @Published var topRankData : [SearchRankingData] = []
    @Published var recipes : [Recipe] = []
    @Published var ingredients : [Ingredient] = []
    @Published var tags : [Tag] = []
    
    
    
    init() {
        SearchService.shard.getSearchRanking(success: { result in
            print("TopRankresult" ,result.data.rankings)
            DispatchQueue.main.async {
                self.topRankData = result.data.rankings
            }
        }, failure: { error in
            print(error)
        })
        
    }
    
    func getSearch() {
        SearchService.shard.getSearch(parameters: ["lastId" : "" , "recipeNames" : [], "ingredients" : [] , "size" : "10"]) { result in
            print("check result ::" , result)
            DispatchQueue.main.async {
                self.recipes = result.data.map { Recipe(postId: $0.postId, recipeName: $0.recipeName, introduction: $0.introduction, imageFilePath: $0.imageFilePath, likeCount: $0.likeCount, foodIngredients: $0.foodIngredients, userNickName: $0.userNickName ?? "" )}
                self.ingredients = result.data.map { Ingredient(postId: $0.postId, recipeName: $0.recipeName, introduction: $0.introduction, imageFilePath: $0.imageFilePath, likeCount: $0.likeCount, foodIngredients: $0.foodIngredients, userNickName: $0.userNickName ?? "" )}
            }
        } failure: { error in
            print(error)
        }
    }
    
    func getCurrentDateString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    
    func removeTag(tag: String) {
        tags.removeAll { $0.value == tag }
    }

    
    

}






struct Recipe: Identifiable , Decodable {
    var id = UUID()
    let postId: Int
    let recipeName: String
    let introduction: String
    let imageFilePath: String
    let likeCount:  Int
    let foodIngredients : [String]
    let userNickName : String?
    
    // Computed property to get UIImage from the URL
    var image: UIImage? {
        var loader = ImageLoader()
        
        guard let url = URL(string: "\(Environment.AwsBaseURL)/\(imageFilePath)") else {
            return nil
        }
        loader.loadImage(from: "\(Environment.AwsBaseURL)/\(imageFilePath)")
        return loader.image
                                
    }
}

struct Ingredient: Identifiable , Decodable {
    var id = UUID()
    let postId: Int
    let recipeName: String
    let introduction: String
    let imageFilePath: String
    let likeCount:  Int
    let foodIngredients : [String]
    let userNickName : String?
    
    // Computed property to get UIImage from the URL
    var image: UIImage? {
        var loader = ImageLoader()
        
        guard let url = URL(string: "\(Environment.AwsBaseURL)/\(imageFilePath)") else {
            return nil
        }
        loader.loadImage(from: "\(Environment.AwsBaseURL)/\(imageFilePath)")
        return loader.image
                                
    }
}
