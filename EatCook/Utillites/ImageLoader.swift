//
//  ImageLoader.swift
//  EatCook
//
//  Created by 강신규 on 6/27/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = addHeader()
//        let token = DataStorage.shared.getString(forKey: DataStorageKey.Authorization)
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("url :::" , url)
            print("data :::" , data)
            print("response :: " , response)
            if let responseBody = String(data: data ?? Data(), encoding: .utf8) {
                print("Response body: \(responseBody)")
            } else {
                print("Failed to convert data to string")
            }
            
            if let data = data, let uiImage = UIImage(data: data) {
            
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }.resume()
    }
    
    
    
    private func addHeader() -> [String: String] {
        var header: [String:String] = [:]
        header["Accept"] = "application/json"
        header["User-Agent"] = "iPhone"
        return header
    }
}
