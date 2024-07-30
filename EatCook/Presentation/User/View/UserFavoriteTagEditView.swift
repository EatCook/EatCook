//
//  UserFavoriteTagEditView.swift
//  EatCook
//
//  Created by 이명진 on 4/27/24.
//

import SwiftUI


struct FavoriteFoodTag {
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

struct FoodThemeTag {
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

struct UserFavoriteTagEditView: View {
    
    @StateObject private var viewModel = UserFavoriteTagViewModel(
        myPageUseCase: MyPageUseCase(
            eatCookRepository: EatCookRepository(
                networkProvider: NetworkProviderImpl(
                    requestManager: NetworkManager()
                )
            )
        )
    )
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    @State private var selectedFoodThemeTag: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("관심요리")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.gray8)
                
                Text("최대 3개까지 선택 가능해요.")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray6)
                
                ChipLayout(verticalSpacing: 16, horizontalSpacing: 8) {
                    ForEach(viewModel.foodTag.indices, id: \.self) { index in
                        let model = viewModel.foodTag[index]
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                let selectedCount = viewModel.foodTag.filter { $0.isSelected }.count
                                
                                if selectedCount < 3 || model.isSelected {
                                    viewModel.foodTag[index].isSelected.toggle()
                                } else {
                                    print("3개까지 선택 가능함.")
                                }
                                print(viewModel.foodTag.filter { $0.isSelected })
                            }
                        } label: {
                            Text(model.title)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .font(.system(size: 14))
                                .foregroundStyle(model.isSelected ? .white : .gray6)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .foregroundStyle(model.isSelected ? .primary6 : .gray2)
                                )
                        }
                        
                    }
                }
                .padding(.vertical, 24)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("나의 식생활 테마")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.gray8)
                
                Text("한 개만 선택 가능해요.")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray6)
                
                ChipLayout(verticalSpacing: 16, horizontalSpacing: 8) {
                    ForEach(viewModel.foodThemeTag.indices, id: \.self) { index in
                        let model = viewModel.foodThemeTag[index]
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                for i in 0..<viewModel.foodThemeTag.count {
                                    viewModel.foodThemeTag[i].isSelected = false
                                }
                                viewModel.foodThemeTag[index].isSelected = true
                                selectedFoodThemeTag = viewModel.foodThemeTag[index].title
                                print(selectedFoodThemeTag)
                            }
                        } label: {
                            Text(model.title)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .font(.system(size: 14))
                                .foregroundStyle(model.isSelected ? .white : .gray6)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .foregroundStyle(model.isSelected ? .primary6 : .gray2)
                                )
                        }
                    }
                }
                .padding(.vertical, 24)
            }
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.requestMyFavoriteTagUpdate()
                    
                    if !viewModel.isUpdate && viewModel.isUpdateError == nil {
                        print("업데이트 성공!!!!")
                        naviPathFinder.pop()
                    }
                }
            } label: {
                Text("완료")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(height: 52)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primary7)
                    }
            }
            .padding(.bottom)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .onAppear {
            viewModel.responseMyFavoriteTag()
        }
        .navigationTitle("관심 요리 편집")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
    UserFavoriteTagEditView()
        .environmentObject(NavigationPathFinder.shared)
}
