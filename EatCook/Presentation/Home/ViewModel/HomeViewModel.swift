//
//  HomeViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import Foundation

class HomeViewModel : ObservableObject {
    
    
    
    init() {
        MainService.shard.getUserInfo(success: { result in
            print("getUserInfo" ,result)
 
            
            
            
        }, failure: { error in
            print(error)
        })
        
        MainService.shard.getUserInterest(success: { result in
            print("getUserInterest" ,result)
            
            
            
        }, failure: { error in
            print(error)
        })
    
        MainService.shard.getUserSpecial(success: { result in
            print("getUserSpecial" ,result)
            
            
            
        }, failure: { error in
            print(error)
        })


        
    }
    
    
    
    
}
