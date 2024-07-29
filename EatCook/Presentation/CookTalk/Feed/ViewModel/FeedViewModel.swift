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
    
    @Published var feedData: CookTalkFeedResponseData?
    @Published var followData: CookTalkFollowResponseData?
    
    @Published var feedDataIsLoading: Bool = false
    @Published var feedError: String? = nil
    @Published var followDataIsLoading: Bool = false
    @Published var followError: String? = nil
    
    init(useCase: CookTalkUseCase) {
        self.cookTalkUseCase = useCase
    }
    
    
}

extension FeedViewModel {
    func responseCookTalkFeed() {
        feedDataIsLoading = true
        feedError = nil
        
        cookTalkUseCase.responseCookTalkFeed()
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
                self.feedData = response.data
            }
            .store(in: &cancellables)
    }
    
    func responseCookTalkFollow() {
        followDataIsLoading = true
        followError = nil
        
        cookTalkUseCase.responseCookTalkFollow()
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
                self.followData = response.data
            }
            .store(in: &cancellables)
    }
    
    
}

