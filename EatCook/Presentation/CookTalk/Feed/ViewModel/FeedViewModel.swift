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
    
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    init(useCase: CookTalkUseCase) {
        self.cookTalkUseCase = useCase
    }
    
    
}

extension FeedViewModel {
    func responseCookTalkFeed() {
        isLoading = true
        error = nil
        
        cookTalkUseCase.responseCookTalkFeed()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.error = error.localizedDescription
                }
            } receiveValue: { response in
                self.feedData = response.data
            }
            .store(in: &cancellables)
    }
    
    func responseCookTalkFollow() {
        cookTalkUseCase.responseCookTalkFollow()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("CookTalkFollow Response Finished")
                case .failure(let error):
//                    self.error = error.localizedDescription
                    print("CookTalkFollow Response Error: \(error)")
                }
            } receiveValue: { response in
                self.followData = response.data
            }
            .store(in: &cancellables)
    }
    
    
}

