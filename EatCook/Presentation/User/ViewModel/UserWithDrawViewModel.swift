//
//  UserWithDrawViewModel.swift
//  EatCook
//
//  Created by 이명진 on 8/14/24.
//

import SwiftUI
import Combine


final class UserWithDrawViewModel: ObservableObject {
    
    private var myPageUseCase: MyPageUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var withDrawCompleted: Bool = false
    
    init(
        myPageUseCase: MyPageUseCase
    ) {
        self.myPageUseCase = myPageUseCase
    }
    
    
}

extension UserWithDrawViewModel {
    
    func requestWithDraw() {
        
        myPageUseCase.requestUserWithDraw()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("회원탈퇴 완료.!!!")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print(response)
                self.withDrawCompleted = response.success
            }
            .store(in: &cancellables)
    }
}
