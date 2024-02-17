//
//  RecipeCreateView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct RecipeCreateView: View {
    @State private var titleTextInput: String = ""
    @State private var descriptionTextInput: String = ""
    
    let characterLimit = 100
    let placeholder = "내 레시피 소개글을 입력해주세요."
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                EmptyImageView()
                
                TextInputView()
            }
            .padding(24)
            
            VStack(spacing: 12) {
                Text("요리 재료")
                
                ThemeChoiceView()
                
                Text("조리시간")
                
                Text("레시피 조리 과정")
            }
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.1))
        }
        .navigationTitle("글쓰기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        
    }
    
    @ViewBuilder
    func TextInputView() -> some View {
        VStack(spacing: 12) {
            TextField("레시피명을 입력해주세요.", text: $titleTextInput)
                .padding(.horizontal, 8)
            
            Divider()
            
            VStack {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $descriptionTextInput)
                        .frame(height: 150)
                        .onChange(of: descriptionTextInput) { newValue in
                            if newValue.count > characterLimit {
                                descriptionTextInput = String(newValue.prefix(characterLimit))
                            }
                        }
                    
                    if descriptionTextInput.isEmpty {
                        Text(placeholder)
                            .foregroundStyle(.gray)
                            .padding(.leading, 8)
                            .padding(.top, 8)
                            .allowsHitTesting(false)
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Text("\(descriptionTextInput.count) / \(characterLimit)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
        }
    }
    
    @ViewBuilder
    func AddIngredentsTagView() -> some View {
        
    }
    
    @ViewBuilder
    func ThemeChoiceView() -> some View {
        VStack {
            Text("테마 선택")
                .font(.title3.bold())
            
            
        }
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
            //                .fill(.white)
            //                .stroke(Color.gray, lineWidth: 1)
        }
    }
    
    @ViewBuilder
    func CookTimerView() -> some View {
        
    }
    
    @ViewBuilder
    func CreateDetailView() -> some View {
        
    }
}

#Preview {
    RecipeCreateView()
}
