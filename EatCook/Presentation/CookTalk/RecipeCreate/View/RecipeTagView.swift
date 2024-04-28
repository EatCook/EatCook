//
//  RecipeTagView.swift
//  EatCook
//
//  Created by 이명진 on 3/2/24.
//

import SwiftUI

struct RecipeTagView: View {
    @State private var tags: [Tag] = []
//    @State private var tags: [String] = []
    @State private var textFieldText: String = ""
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("요리 재료")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        tags.removeAll()
                    }
                } label: {
                    Text("전체삭제")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.gray5)
                }
            }
            .padding(16)
            
            TextField("재료를 입력해주세요", text: $textFieldText, onCommit: {
                let data = Tag(value: textFieldText)
                withAnimation(.easeInOut(duration: 0.2)) {
                    tags.append(data)
                    self.textFieldText = ""
                }
            })
                .padding()
                .modifier(CustomBorderModifier())
                
//                .onChange(of: <#T##Equatable#>, <#T##action: (Equatable, Equatable) -> Void##(Equatable, Equatable) -> Void##(_ oldValue: Equatable, _ newValue: Equatable) -> Void#>)
//            TagField(tags: $tags)
//                .modifier(CustomBorderModifier())
//                .padding(.horizontal)
            ChipLayout(verticalSpacing: 8, horizontalSpacing: 8) {
                ForEach(tags.indices, id: \.self) { index in
                    let data = tags[index]
                    HStack(spacing: 8) {
                        Text(data.value)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.gray6)
                        
                        Button {
                            tags.remove(at: index)
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
                    naviPathFinder.addPath(.recipeStep(""))
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
}

#Preview {
    NavigationStack {
        RecipeTagView()
            .environmentObject(NavigationPathFinder.shared)        
    }
}
