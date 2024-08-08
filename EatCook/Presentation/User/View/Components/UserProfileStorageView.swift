//
//  UserProfileStorageView.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

struct UserProfileStorageView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    let items = Array(1...30)
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.myPageArchiveData, id: \.id) { item in
                    ZStack(alignment: .bottomTrailing) {
                        if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(item.postImagePath)") {
                            AutoRetryImage(url: imageUrl, failImageType: .recipeMain)
                                .frame(width: 110, height: 110)
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .frame(width: 15, height: 19)
                            .foregroundStyle(.white)
                            .padding(.trailing, 8)
                            .padding(.bottom, 8)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .onAppear {
            viewModel.responseMyPageArchives()
        }
    }
}

//#Preview {
//    UserProfileStorageView(viewModel: <#UserProfileViewModel#>)
//}
