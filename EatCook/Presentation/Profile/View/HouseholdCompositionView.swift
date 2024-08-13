//
//  HouseholdCompositionView.swift
//  EatCook
//
//  Created by 김하은 on 2/14/24.
//

import SwiftUI

struct HouseholdCompositionView: View {
    var email: String
    var nickName : String
    var cookingType: [String]
    var imageURL: URL?
    var userImageExtension : String?
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    @StateObject private var householdCompositionViewModel : HouseholdCompositionViewModel
    @State private var showUploadingAlert: Bool = false

    init(email: String, nickName : String ,cookingType: [String], imageURL: URL? , userImageExtension : String?) {
        self.email = email
        self.nickName = nickName
        self.cookingType = cookingType
        self.imageURL = imageURL
        self.userImageExtension = userImageExtension
        
        // Initialize the StateObject with the wrapped value
        _householdCompositionViewModel = StateObject(wrappedValue: HouseholdCompositionViewModel(authUseCase : AuthUseCase(eatCookRepository: EatCookRepository(networkProvider: NetworkProviderImpl(requestManager: NetworkManager()))) , email: email,nickName: nickName ,cookingType: cookingType, imageURL: imageURL , userImageExtension : userImageExtension))
    }
    

    let columns = [GridItem(.flexible())]
    @State var isButtonEnabled = false
    @State private var selectedItem: String? = nil
    
    var body: some View {
//        NavigationStack {
            VStack {
                Text("주로 어떤 식사를 하나요?")
                    .bold()
                    .font(.title)
                
                Text("나의 생활 유형에 맞는\n레시피만 골라 볼 수 있어요.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .lineLimit(2)
                    .padding(.horizontal, 24)
                
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(Household.themes, id: \.id) { data in
                        Button(action: {
                            householdCompositionViewModel.lifeType = data.title
                        }, label: {
                            Text(data.img)
                            Text(data.title)
                                .font(.callout)
                                .foregroundColor(.black)
                                .bold()
                        })
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(householdCompositionViewModel.lifeType == data.title ? Color.primary7 : Color.gray1, lineWidth:1)
                        )
                    }
                }.padding(.horizontal, 40)
                .padding(.top, 65)
                
                Spacer()
                
                Button(action: {
                    Task {
                        await householdCompositionViewModel.addSignUp()
                        await householdCompositionViewModel.uploadImage()
                        
                        if !householdCompositionViewModel.isUpLoading && householdCompositionViewModel.isUpLoadingError == nil  {
                            naviPathFinder.popToRoot()
                        } else if let error = householdCompositionViewModel.isUpLoadingError {
                            print(error)
                            showUploadingAlert = true
                        }
                        
                    }
//                    householdCompositionViewModel.addSignUp { result in
//                        if result.success {
//                            navigateToHomeView = true
////                            TODO : 이미지 URL 받아서 전송
//                        }else{
////                            TODO : Alert 추가
//                        }
//                    }

                }) {
                    Text("다음")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.primary7) // 활성화 상태에 따라 배경 색상 변경
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 46)
                }.disabled(householdCompositionViewModel.lifeType == "")
                
        
//                NavigationLink(destination: HomeView().toolbarRole(.editor), isActive: $navigateToHomeView) {
//                    EmptyView()
//                }
                
            }
            .padding(.top, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray1)
            .navigationBarTitleDisplayMode(.inline)
        }
//    }
}

extension HouseholdCompositionView {
    struct Household {
        let id = UUID()
        let img : String
        let title: String
        
        static let themes: [Household] = [
            Household(img: "🔥",  title: "다이어트만 n년째"),
            Household(img : "🥦" , title: "건강한 식단관리"),
            Household(img : "🍙" ,  title: "편의점은 내 구역"),
            Household(img : "🍕" , title: "배달음식 단골고객"),
            Household(img : "🍱" , title: "밀키트 lover"),
        ]
    }
}

#Preview {
    HouseholdCompositionView(email: "rkdtlscks123@naver.com", nickName: "신규" ,cookingType: ["일식", "한식"], imageURL: nil , userImageExtension: "jpg")
}
