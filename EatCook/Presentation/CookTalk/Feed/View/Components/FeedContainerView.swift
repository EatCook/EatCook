//
//  FeedContainerView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct FeedContainerView: View {
    @ObservedObject var viewModel: FeedViewModel
    var feedType: CookTalkTabCase = .cooktalk
    
    var body: some View {
        VStack(spacing: 16) {
            switch feedType {
            case .cooktalk:
                if viewModel.feedDataIsLoading {
                    ProgressView()
                } else if let error = viewModel.feedError {
                    Text(error)
                } else if let feedData = viewModel.feedData {
                    ForEach(feedData.cookTalkDtoList, id: \.id) { data in
                        FeedRowView(cookTalkFeedData: data)
                    }
                }
            case .follow:
                if viewModel.followDataIsLoading {
                    ProgressView()
                } else if let error = viewModel.followError {
                    Text(error)
                } else if let followData = viewModel.followData {
                    ForEach(followData.cookTalkDtoList, id: \.id) { data in
                        FollowRowView(cookTalkFollowData: data)
                    }
                }
            }
            
        }
    }
}

#Preview {
    FeedView()
}
