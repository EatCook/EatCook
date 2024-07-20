//
//  RecipeTagView.swift
//  EatCook
//
//  Created by 이명진 on 3/2/24.
//

import SwiftUI

struct RecipeTagView: View {
//    @State private var tags: [Tag] = []
//    @State private var textFieldText: String = ""
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    @ObservedObject var viewModel: RecipeCreateViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("요리 재료")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.ingredientsTags.removeAll()
                    }
                } label: {
                    Text("전체삭제")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.gray5)
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 16)
            
            TextField("재료를 입력해주세요", text: $viewModel.ingredientsInputText)
                .onSubmit {
                    addTag()
                }
                .padding()
                .modifier(CustomBorderModifier())
                
            ChipLayout(verticalSpacing: 8, horizontalSpacing: 8) {
                ForEach(viewModel.ingredientsTags.indices, id: \.self) { index in
                    let data = viewModel.ingredientsTags[index]
                    HStack(spacing: 8) {
                        Text(data.value)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.gray6)
                        
                        Button {
                            viewModel.ingredientsTags.remove(at: index)
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(.gray6)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray3)
                    }
                    
                }
            }
            .padding(4)
            
            Spacer()
            
            HStack(spacing: 15) {
                Button {
                    naviPathFinder.pop()
                } label: {
                    Text("이전")
                        .padding()
                        .foregroundStyle(.gray5)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .modifier(CustomBorderModifier())
                }
                
                Button {
                    naviPathFinder.addPath(.recipeStep(viewModel))
                } label: {
                    Text("다음")
                        .padding()
                        .foregroundStyle(.white)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .modifier(CustomBorderModifier(lineWidth: 0, background: .primary7))
                }
            }
            
        }
        .padding()
        .background(.gray1)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    naviPathFinder.popToRoot()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                }
            }
        }
        
    }
    
    private func addTag() {
        guard !viewModel.ingredientsInputText.isEmpty else { return }
        
        let data = Tag(value: viewModel.ingredientsInputText)
        withAnimation(.easeIn(duration: 0.2)) {
            viewModel.ingredientsTags.append(data)
            viewModel.ingredientsInputText = ""
        }
    }
}

//#Preview {
//    NavigationStack {
//        RecipeTagView()
//            .environmentObject(NavigationPathFinder.shared)
//    }
//}
