//
//  UserProfileViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import Foundation
import Combine

final class UserProfileViewModel: ObservableObject {
    
    private let myPageUseCase: MyPageUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var myPageData = MyPageDataResponse()
    @Published var myPageContentsData: [MyPageContent] = []
    @Published var hasNextPage: Bool = false
    
    @Published var myPageArchiveData: [MyPageArchiveData] = []
    
    init(myPageUseCase: MyPageUseCase) {
        self.myPageUseCase = myPageUseCase
    }
    
}

extension UserProfileViewModel {
    func responseMyPage(_ page: Int) {
        
        myPageUseCase.responseMyPage(page)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("마이페이지 응답 완료")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.myPageData = response.data
                self.myPageContentsData = response.data.posts.content
                self.hasNextPage = response.data.posts.hasNextPage
            }
            .store(in: &cancellables)
    }
    
    func responseMyPageArchives() {
        
        myPageUseCase.responseMyPageArchive()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("보관함 응답 완료")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.myPageArchiveData = response.data
            }
            .store(in: &cancellables)

    }
    
}
