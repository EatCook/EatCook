//
//  SearchViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import Foundation
import SwiftUI

class SearchViewModel : ObservableObject {
    
    
    @State var topRankData : [String] = []
    
    
    init() {
        SearchService.shard.getSearchRanking(success: { result in
            print("TopRankresult" ,result)
        }, failure: { error in
            print(error)
        })
        
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
    
}
