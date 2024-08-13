//
//  FeedViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import Foundation
import Combine

final class FeedViewModel: ObservableObject {
    
    private let cookTalkUseCase: CookTalkUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var feedData: [CookTalkFeedResponseList] = []
    @Published var followData: [CookTalkFollowResponseList] = []
    
    @Published var feedDataIsLoading: Bool = false
    @Published var feedError: String? = nil
    @Published var feedDataHasNextPage: Bool = false
    @Published var feedDataCurrentPage: Int = 0
    
    @Published var followDataIsLoading: Bool = false
    @Published var followError: String? = nil
    @Published var followDataHasNextPage: Bool = false
    @Published var followDataCurrentPage: Int = 0
    
    init(useCase: CookTalkUseCase) {
        self.cookTalkUseCase = useCase
    }
    
}

extension FeedViewModel {
    func responseCookTalkFeed(_ page: Int) {
        feedDataIsLoading = true
        feedError = nil
        
        cookTalkUseCase.responseCookTalkFeed(page)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.feedDataIsLoading = false
                case .failure(let error):
                    self.feedDataIsLoading = false
                    self.feedError = error.localizedDescription
                }
            } receiveValue: { response in
                if page == 0 {
                    self.feedData = response.data.content
                } else {
                    self.feedData.append(contentsOf: response.data.content)
                }
                self.feedDataHasNextPage = response.data.hasNextPage
                self.feedDataCurrentPage = response.data.page
            }
            .store(in: &cancellables)
    }
    
    func responseCookTalkFollow(_ page: Int) {
        followDataIsLoading = true
        followError = nil
        
        cookTalkUseCase.responseCookTalkFollow(page)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("CookTalkFollow Response Finished")
                    self.followDataIsLoading = false
                case .failure(let error):
                    self.followDataIsLoading = false
                    self.followError = error.localizedDescription
                    print("CookTalkFollow Response Error: \(error)")
                }
            } receiveValue: { response in
                if page == 0 {
                    self.followData = response.data.content
                } else {
                    self.followData.append(contentsOf: response.data.content)
                }
                self.followDataHasNextPage = response.data.hasNextPage
                self.followDataCurrentPage = response.data.page
            }
            .store(in: &cancellables)
    }
    
    
}

